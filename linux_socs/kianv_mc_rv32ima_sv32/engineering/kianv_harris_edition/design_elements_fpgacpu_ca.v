//# A Priority Encoder

// Takes in a bitmask of multiple requests and returns the zero-based index of
// the set request bit with the highest priority. The least-significant bit
// has highest priority. If no request bits are set, the output is zero, but
// signalled as invalid.  This Priority Encoder is very closely related to the
// [Number of Trailing Zeros](./Number_of_Trailing_Zeros.html) module.

// For example:

// * 11111 --> 00000 (0)
// * 00010 --> 00001 (1)
// * 01100 --> 00010 (2)
// * 11000 --> 00011 (3)
// * 10000 --> 00011 (4)
// * 00000 --> 00000 (0, invalid)

// The Priority Encoder translates bitmasks to integers, and so can be
// generally used to convert separate physical events into a number for later
// processing or to index into a table, while filtering out multiple
// simultaneous events into only one.

module Priority_Encoder #(
    parameter WORD_WIDTH = 32
) (
    input  wire [WORD_WIDTH-1:0] word_in,
    output wire [WORD_WIDTH-1:0] word_out,
    output reg                   word_out_valid
);

  localparam WORD_ZERO = {WORD_WIDTH{1'b0}};

  initial begin
    word_out_valid = 1'b0;
  end

  // First, isolate the least-significant 1 bit

  wire [WORD_WIDTH-1:0] lsb_1;

  Bitmask_Isolate_Rightmost_1_Bit #(
      .WORD_WIDTH(WORD_WIDTH)
  ) find_lsb_1 (
      .word_in (word_in),
      .word_out(lsb_1)
  );

  // A single bit is a power of two, so take its logarithm, which returns its
  // zero-based index, which is also the encoded priority.

  wire logarithm_undefined;

  Logarithm_of_Powers_of_Two #(
      .WORD_WIDTH(WORD_WIDTH)
  ) calc_bit_index (
      .one_hot_in         (lsb_1),
      .logarithm_out      (word_out),
      .logarithm_undefined(logarithm_undefined)
  );

  // However, there is a corner case: if the input word is all zero then the
  // logarithm output is undefined, and so the output number is zero as if the
  // zeroth bit was set, but invalid.

  always @(*) begin
    word_out_valid = (logarithm_undefined == 1'b0);
  end

endmodule


//# Bitmask: Isolate Rightmost 1 Bit

// Credit: [Hacker's Delight](./reading.html#Warren2013), Section 2-1: Manipulating Rightmost Bits

// Use the following formula to isolate the rightmost 1-bit, producing 0 if
// none (e.g., 01011000 -> 00001000)

// This function can trivially implement a [Priority
// Arbiter](./Arbiter_Priority.html), with the highest priority given to the
// least-significant bit, and is the building block of more complex arbiters.

`default_nettype none

module Bitmask_Isolate_Rightmost_1_Bit #(
    parameter WORD_WIDTH = 0
) (
    input  wire [WORD_WIDTH-1:0] word_in,
    output reg  [WORD_WIDTH-1:0] word_out
);

  initial begin
    word_out = {WORD_WIDTH{1'b0}};
  end

  always @(*) begin
    word_out = word_in & (-word_in);
  end

endmodule


//# Logarithm of Powers of Two

// Translates a power-of-2 binary value (a one-hot bitmask) into its integer
// base-2 logarithm. For example:

// * log<sub>2</sub>(0001) -> log<sub>2</sub>(2<sup>0</sup>) -> log<sub>2</sub>(1) -> 0
// * log<sub>2</sub>(0010) -> log<sub>2</sub>(2<sup>1</sup>) -> log<sub>2</sub>(2) -> 1
// * log<sub>2</sub>(0100) -> log<sub>2</sub>(2<sup>2</sup>) -> log<sub>2</sub>(4) -> 2
// * log<sub>2</sub>(1000) -> log<sub>2</sub>(2<sup>3</sup>) -> log<sub>2</sub>(8) -> 3

// We can see the logarithm of a power-of-2 is simply the index of the single
// set bit: log<sub>2</sub>(2<sup>set_bit_index</sup>) = set_bit_index.

// If the input is not a power-of-2 (more than one set bit), then this
// implementation will output the bitwise-OR of the logarithm of each set bit
// treated as a power-of-2, which I'm not sure has any use or meaning. To save
// hardware (we'd need a [Population Count](./Population_Count.html) or a pair
// of [priority bitmasks](./Bitmask_Isolate_Rightmost_1_Bit.html)), we don't signal these
// cases.
// Also, this calculation fails if no bits are set, since log<sub>2</sub>(0)
// is undefined, and we cannot output zero as that's a valid logarithm. To
// represent the undefined case, we will set an extra bit to declare the output
// undefined, via a simple NOR-reduction of the input.

// We can't implement using a translation table, as with the
// [Static Address Translator](./Address_Translator_Static.html), since we
// would have to create a table capable of holding all 2<sup>WORD_WIDTH</sup>
// possible values, and that would take a *long* time to synthesize and optimize,
// as well as require a lot of system memory.
// Instead, we precalculate each possible logarithm (one per input bit) and
// gate its value based on whether the corresponding input bit is set. We then
// OR-reduce all these possible logarithms into the final answer. We can use
// this implementation method since the amount of logic scales linearly with
// WORD_WIDTH.

// You can use this module to implement unsigned division by powers-of-2 by
// shifting right by the logarithm value. However, *signed* division by
// powers-of-2 has a complication. See [Hacker's
// Delight](./reading.html#Warren2013), Section 10-1, "Signed Division by
// a Known Power of 2".

// When combined with [Bitmask: Isolate Rightmost
// 1 Bit](./Bitmask_Isolate_Rightmost_1_Bit.html), this module forms the basis
// for the very useful Number of Trailing Zeros (ntz) function. Add a [Word
// Reverser](./Word_Reverser.html) and you can compute Number of Leading Zeros
// (nlz).

`default_nettype none

module Logarithm_of_Powers_of_Two #(
    parameter WORD_WIDTH = 0
) (
    input  wire [WORD_WIDTH-1:0] one_hot_in,
    output wire [WORD_WIDTH-1:0] logarithm_out,
    output reg                   logarithm_undefined
);

  localparam WORD_ZERO = {WORD_WIDTH{1'b0}};

  initial begin
    logarithm_undefined = 1'b0;
  end

  // To keep the interface clean, logarithm_out has the same WORD_WIDTH as
  // one_hot_in. To calculate each possbile logarithm in parallel, we need an
  // array of one output word per input bit. But we must use a flat vector here
  // instead of an array since we will be passing this vector of words to
  // a Word_Reducer module, and we can't pass multidimensional arrays through
  // module ports in Verilog-2001. This means you will hit the Verilog vector
  // width limit of about a million when WORD_WIDTH reaches about 1024, though
  // simulation and synthesis will have become impractically slow long before
  // then.

  localparam TOTAL_WIDTH = WORD_WIDTH * WORD_WIDTH;
  localparam TOTAL_ZERO = {TOTAL_WIDTH{1'b0}};

  reg [TOTAL_WIDTH-1:0] all_logarithms = TOTAL_ZERO;

  // Most of those logarithm output bits remain a constant zero (and so require
  // no logic) since representing the value of a binary number up to
  // 2<sup>N</sup>-1 require at most log<sub>2</sub>(N) bits. Therefore,
  // representing log<sub>2</sub>(2<sup>N</sup>-1) in binary only needs
  // log<sub>2</sub>(log<sub>2</sub>(N)) bits, which is a value that grows
  // __very__ slowly. Having output bits stuck at zero will raise CAD tool
  // warnings, but that's a lot less error-prone than having the enclosing logic
  // calculate the required output logarithm bit width.

  // This implementation would ultimately fail if the computed logarithm needs
  // more bits than a 32-bit Verilog integer. However, as explained above, that
  // would require an input value exceeding 2<sup>2<sup>32</sup></sup>-1, which
  // is 2<sup>32</sup> bits long. You are not likely to reach this limit.

  // So we pre-compute how many bits we will need to represent the logarithm,
  // and also create some zero-padding to expand the logarithm back to
  // WORD_WIDTH.

  //    `include "clog2_function.vh"
  localparam LOGARITHM_WIDTH = $clog2(WORD_WIDTH);
  localparam PAD_WIDTH = WORD_WIDTH - LOGARITHM_WIDTH;
  localparam PAD = {PAD_WIDTH{1'b0}};

  // Then, for each set input bit, put its logarithm (the bit index) into the
  // corresponding array word, else put zero. Note how we slice the integer
  // logarithm down to the necessary bits and then pad those back up to the
  // array word width.

  generate
    genvar i;
    for (i = 0; i < WORD_WIDTH; i = i + 1) begin : per_input_bit
      always @(*) begin
        all_logarithms[WORD_WIDTH*i +: WORD_WIDTH] = (one_hot_in[i] == 1'b1) ? {PAD, i[LOGARITHM_WIDTH-1:0]} : WORD_ZERO;
      end
    end
  endgenerate

  // Then, we OR-reduce the array of possible logarithms down to one.

  Word_Reducer #(
      .OPERATION ("OR"),
      .WORD_WIDTH(WORD_WIDTH),
      .WORD_COUNT(WORD_WIDTH)
  ) combine_logarithms (
      .words_in(all_logarithms),
      .word_out(logarithm_out)
  );

  // Finally, we detect the case where all input bits are zero and the logarithm
  // is undefined.

  always @(*) begin
    logarithm_undefined = (one_hot_in == WORD_ZERO);
  end

endmodule


//# Boolean Word Reducer

// Reduces multiple words into a single word, using the given Boolean
// operation. Put differently: it's a [bit-reduction](./Bit_Reducer.html) of
// each bit position across all words.  The `words_in` input contains all the
// input words concatenated one after the other.

// A common use case is to compute multiple results and their selecting
// conditions in parallel, then [annul](./Annuller.html) all but the result you
// want and OR-reduce them into a single result. Or don't annul the results,
// but NAND them to see each bit position where the results disagree, and then
// maybe bit-reduce *that* to signal if *any* of the results disagree,
// possibly signalling an error.

`default_nettype none

module Word_Reducer #(
    parameter OPERATION  = "",
    parameter WORD_WIDTH = 0,
    parameter WORD_COUNT = 0,

    // Don't change at instantiation
    parameter TOTAL_WIDTH = WORD_WIDTH * WORD_COUNT
) (
    input  wire [TOTAL_WIDTH-1:0] words_in,
    output wire [ WORD_WIDTH-1:0] word_out
);

  localparam BIT_ZERO = {WORD_COUNT{1'b0}};

  // Instantiate the following hardware once for each bit position in a word.
  // The `bit_word` gathers the bit at a given position from all the words.
  // (e.g.: all the first bits, all the second bits, etc...) Then, for each
  // word, extract the given bit position into the `bit_word`.

  generate

    genvar i, j;

    for (j = 0; j < WORD_WIDTH; j = j + 1) begin : per_bit

      reg [WORD_COUNT-1:0] bit_word = BIT_ZERO;

      for (i = 0; i < WORD_COUNT; i = i + 1) begin : per_word
        always @(*) begin
          bit_word[i] = words_in[(WORD_WIDTH*i)+j];
        end
      end

      // Then reduce the `bit_word` into the output bit using the specified Boolean
      // function.  (i.e.: all input words first bits, gathered into `bit_word`,
      // reduce to the first output word bit).  I use the
      // [Bit_Reducer](./Bit_Reducer.html) here to both express that word reduction
      // is a composition of bit reduction, and to avoid having to rewrite each
      // possible case along with the special linter directives to avoid width
      // warnings.

      // The downside is that the list of possible operations is not visible here,
      // but if you need to find them out, then reading the bit reducer code is the
      // best documentation. And if you need to add an operation, then the word
      // reducer code remains unchanged.

      Bit_Reducer #(
          .OPERATION  (OPERATION),
          .INPUT_COUNT(WORD_COUNT)
      ) bit_position (
          .bits_in(bit_word),
          .bit_out(word_out[j])
      );
    end

  endgenerate

endmodule

//## Alternate Implementation

// There exists an alternate implementation of word reduction which is
// differently elegant, but has a couple of pitfalls and cannot re-use the bit
// reducer code. I'll outline it here because it uses looped partial
// calculations with a peeled-out first iteration, which is a common code
// pattern.

// Repeatedly using a register in an unclocked loop expresses a combinational
// logic loop, which must be avoided: without special effort the CAD tool
// cannot analyze it for timing, or sometimes even synthesize it. So we create
// an array of registers to hold each partial result, and initialize them to
// zero.

//    reg [WORD_WIDTH-1:0] partial_reduction [WORD_COUNT-1:0];
//
//    integer i;
//
//    initial begin
//        for(i=0; i < WORD_COUNT; i=i+1) begin
//            partial_reduction[i] = ZERO;
//        end
//    end

// First, connect the zeroth input word to the zeroth partial result.  This
// peels out the first loop iteration, where the read index would be out of
// range (negative!) otherwise.

//    always @(*) begin
//        partial_reduction[0] = in[0 +: WORD_WIDTH];

// Then OR the previous partial result with the current input word, creating
// the next partial result. Note the start index because of the peeled-out
// first iteration: `i=1`.  This is where you would implement each possible
// operation, and most of the code would be duplicated boilerplate, differing
// only by the Boolean operator. This is dull, error-prone, and drags in
// synthesis-time complications, such as linter directives and operation
// selection, into the middle of run-time code.

//        for(i=1; i < WORD_COUNT; i=i+1) begin
//            partial_reduction[i] = partial_reduction[i-1] | words_in[WORD_WIDTH*i +: WORD_WIDTH];
//        end

// The last partial result is the final result.

//        word_out = partial_reduction[WORD_COUNT-1];
//    end


//# Boolean Bit Reducer

// This module generalizes the usual 2-input Boolean functions to their
// n-input reductions, which are interesting and useful:

// * Trivially calculate *any of these* (OR) or *all of these* (AND) conditions and their negations.
// * Calculate even/odd parity (XOR/XNOR)
// * Selectively invert some of the inputs and you can decode any intermediate condition you care to.

// Beginners can use this module to implement any combinational logic while
// knowing a minimum of Verilog (no always blocks, no blocking/non-blocking
// statements, only wires, etc...).

// Experts generally would not use this module. It's far simpler to [express
// the desired conditions directly](./verilog.html#boolean) in Verilog.
// However, there are a few reasons to use it:

// * It will keep your derived schematics clean of multiple random little gates, and generally preserve the schematic layout.
// * If there is a specific meaning to this reduction, you can name the module descriptively.
// * It will make clear which logic gets moved, in or out of that level of hierarchy, by optimization or retiming post-synthesis.

//## Differences with Verilog Reduction Operators

// The specification of reduction operators in Verilog (2001 or SystemVerilog)
// contains an error which does not perform a true reduction when the Boolean
// operator in the reduction contains an inversion (NOR, NAND, XNOR). Instead,
// the operator will perform a non-inverting reduction (e.g.: XOR), then
// invert the final result. For example, `A = ~^B;` (XNOR reduction) should
// perform the following:

// <pre>(((B[0] ~^ B[1]) ~^ B[2]) ~^ B[3) ... </pre>

// but instead performs the following, which is not always equivalent:

// <pre>~(B[0] ^ B[1] ^ B[2] ^ B[3 ...)</pre>

// To implement the correct logical behaviour, we do the reduction in a loop
// using the alternate implementation described in the [Word
// Reducer](./Word_Reducer.html) module.  The differences were
// [spotted](https://twitter.com/wren6991/status/1259098465835106304) by Luke
// Wren ([@wren6991](https://twitter.com/wren6991)).

//## Errors, Verilog Strings, and Linter Warnings

// There's no clean way to stop the CAD tools if the `OPERATION` parameter is
// missing or incorrect. Here, the logic doesn't get generated, which will
// fail pretty fast...

// The `OPERATION` parameter also reveals how strings are implemented in
// Verilog: just a sequence of 8-bit bytes. Thus, if we give `OPERATION`
// a value of `"OR"` (16 bits), it must first get compared against `"AND"` (24
// bits) and `"NAND"` (32 bits). The Verilator linter throws a width mismatch
// warning at those first two comparisons, of course. Width warnings are
// important to spot bugs, so to keep them relevant we carefully disable width
// checks only during the parameter tests.

`default_nettype none

module Bit_Reducer #(
    parameter OPERATION   = "",
    parameter INPUT_COUNT = 0
) (
    input  wire [INPUT_COUNT-1:0] bits_in,
    output reg                    bit_out
);

  initial begin
    bit_out = 1'b0;
  end

  // First, initialize the partial reduction storage. Each partial reduction
  // must be stored in its own storage, else we describe a broken combinational
  // loop.

  // To make the code clearer, `partial_reduction` is read and written in
  // different `always` blocks, so the linter is confused and sees a potential
  // combinational loop, which doesn't exist here because of the non-overlapping
  // indices. So we disable that warning here.

  // verilator lint_off UNOPTFLAT
  reg [INPUT_COUNT-1:0] partial_reduction;
  // verilator lint_on  UNOPTFLAT

  integer i;

  initial begin
    for (i = 0; i < INPUT_COUNT; i = i + 1) begin
      partial_reduction[i] = 1'b0;
    end
  end

  // Then prime the partial reductions with the first input, and read out the
  // result at the last partial reduction.

  always @(*) begin
    partial_reduction[0] = bits_in[0];
    bit_out              = partial_reduction[INPUT_COUNT-1];
  end

  // Finally, select the logic to instantiate based on the `OPERATION`
  // parameter. Each partial reduction is the combination of the previous
  // reduction and the current corresponding input bit.

  generate

    // verilator lint_off WIDTH
    if (OPERATION == "AND") begin
      // verilator lint_on  WIDTH
      always @(*) begin
        for (i = 1; i < INPUT_COUNT; i = i + 1) begin
          partial_reduction[i] = partial_reduction[i-1] & bits_in[i];
        end
      end
    end else
    // verilator lint_off WIDTH
    if (OPERATION == "NAND") begin
      // verilator lint_on  WIDTH
      always @(*) begin
        for (i = 1; i < INPUT_COUNT; i = i + 1) begin
          partial_reduction[i] = ~(partial_reduction[i-1] & bits_in[i]);
        end
      end
    end else
    // verilator lint_off WIDTH
    if (OPERATION == "OR") begin
      // verilator lint_on  WIDTH
      always @(*) begin
        for (i = 1; i < INPUT_COUNT; i = i + 1) begin
          partial_reduction[i] = partial_reduction[i-1] | bits_in[i];
        end
      end
    end else
    // verilator lint_off WIDTH
    if (OPERATION == "NOR") begin
      // verilator lint_on  WIDTH
      always @(*) begin
        for (i = 1; i < INPUT_COUNT; i = i + 1) begin
          partial_reduction[i] = ~(partial_reduction[i-1] | bits_in[i]);
        end
      end
    end else
    // verilator lint_off WIDTH
    if (OPERATION == "XOR") begin
      // verilator lint_on  WIDTH
      always @(*) begin
        for (i = 1; i < INPUT_COUNT; i = i + 1) begin
          partial_reduction[i] = partial_reduction[i-1] ^ bits_in[i];
        end
      end
    end else
    // verilator lint_off WIDTH
    if (OPERATION == "XNOR") begin
      // verilator lint_on  WIDTH
      always @(*) begin
        for (i = 1; i < INPUT_COUNT; i = i + 1) begin
          partial_reduction[i] = ~(partial_reduction[i-1] ^ bits_in[i]);
        end
      end
    end

  endgenerate
endmodule

module Multiplexer_Binary_Behavioural #(
    parameter WORD_WIDTH  = 1,
    parameter ADDR_WIDTH  = 1,
    parameter INPUT_COUNT = 1,

    // Do not set at instantiation
    parameter TOTAL_WIDTH = WORD_WIDTH * INPUT_COUNT
) (
    input  wire [ ADDR_WIDTH-1:0] selector,
    input  wire [TOTAL_WIDTH-1:0] words_in,
    output reg  [ WORD_WIDTH-1:0] word_out
);

  initial begin
    word_out = {WORD_WIDTH{1'b0}};
  end

  always @(*) begin
    word_out = words_in[(selector*WORD_WIDTH)+:WORD_WIDTH];
  end

endmodule

