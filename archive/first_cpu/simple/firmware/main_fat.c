// adapted for kianv riscv hack got from https://github.com/ultraembedded/fat_io_lib
#define NOT_USE_MYSTDLIB
#include <string.h>

#ifndef __FAT_ACCESS_H__
#define __FAT_ACCESS_H__


#ifndef __FAT_DEFS_H__
#define __FAT_DEFS_H__


#ifndef __FAT_OPTS_H__
#define __FAT_OPTS_H__

#ifdef FATFS_USE_CUSTOM_OPTS_FILE
    #include "fat_custom.h"
#endif

//-------------------------------------------------------------
// Configuration
//-------------------------------------------------------------

// Is the processor little endian (1) or big endian (0)
#ifndef FATFS_IS_LITTLE_ENDIAN
    #define FATFS_IS_LITTLE_ENDIAN          1
#endif

// Max filename Length
#ifndef FATFS_MAX_LONG_FILENAME
    #define FATFS_MAX_LONG_FILENAME         260
#endif

// Max open files (reduce to lower memory requirements)
#ifndef FATFS_MAX_OPEN_FILES
    #define FATFS_MAX_OPEN_FILES            2
#endif

// Number of sectors per FAT_BUFFER (min 1)
#ifndef FAT_BUFFER_SECTORS
    #define FAT_BUFFER_SECTORS              1
#endif

// Max FAT sectors to buffer (min 1)
// (mem used is FAT_BUFFERS * FAT_BUFFER_SECTORS * FAT_SECTOR_SIZE)
#ifndef FAT_BUFFERS
    #define FAT_BUFFERS                     1
#endif

// Size of cluster chain cache (can be undefined)
// Mem used = FAT_CLUSTER_CACHE_ENTRIES * 4 * 2
// Improves access speed considerably
//#define FAT_CLUSTER_CACHE_ENTRIES         128

// Include support for writing files (1 / 0)?
#ifndef FATFS_INC_WRITE_SUPPORT
    #define FATFS_INC_WRITE_SUPPORT         1
#endif

// Support long filenames (1 / 0)?
// (if not (0) only 8.3 format is supported)
#ifndef FATFS_INC_LFN_SUPPORT
    #define FATFS_INC_LFN_SUPPORT           1
#endif

// Support directory listing (1 / 0)?
#ifndef FATFS_DIR_LIST_SUPPORT
    #define FATFS_DIR_LIST_SUPPORT          1
#endif

// Support time/date (1 / 0)?
#ifndef FATFS_INC_TIME_DATE_SUPPORT
    #define FATFS_INC_TIME_DATE_SUPPORT     0
#endif

// Include support for formatting disks (1 / 0)?
#ifndef FATFS_INC_FORMAT_SUPPORT
    #define FATFS_INC_FORMAT_SUPPORT        1
#endif

// Sector size used
#define FAT_SECTOR_SIZE                     512

// Printf output (directory listing / debug)
#ifndef FAT_PRINTF
    // Don't include stdio, but there is a printf function available
    #ifdef FAT_PRINTF_NOINC_STDIO
        extern int printf(const char* ctrl1, ... );
        #define FAT_PRINTF(a)               printf a
    // Include stdio to use printf
    #else
        #include "stdlib.c"
        #define FAT_PRINTF(a)               printf a
    #endif
#endif

// Time/Date support requires time.h
#if FATFS_INC_TIME_DATE_SUPPORT
    #include <time.h>
#endif

#endif

#ifndef __FAT_TYPES_H__
#define __FAT_TYPES_H__

// Detect 64-bit compilation on GCC
#if defined(__GNUC__) && defined(__SIZEOF_LONG__)
    #if __SIZEOF_LONG__ == 8
        #define FATFS_DEF_UINT32_AS_INT
    #endif
#endif

//-------------------------------------------------------------
// System specific types
//-------------------------------------------------------------
#ifndef FATFS_NO_DEF_TYPES
    typedef unsigned char uint8;
    typedef unsigned short uint16;

    // If compiling on a 64-bit machine, use int as 32-bits
    #ifdef FATFS_DEF_UINT32_AS_INT
        typedef unsigned int uint32;
    // Else for 32-bit machines & embedded systems, use long...
    #else
        typedef unsigned long uint32;
    #endif
#endif

#ifndef NULL
    #define NULL 0
#endif

//-------------------------------------------------------------
// Endian Macros
//-------------------------------------------------------------
// FAT is little endian so big endian systems need to swap words

// Little Endian - No swap required
#if FATFS_IS_LITTLE_ENDIAN == 1

    #define FAT_HTONS(n) (n)
    #define FAT_HTONL(n) (n)

// Big Endian - Swap required
#else

    #define FAT_HTONS(n) ((((uint16)((n) & 0xff)) << 8) | (((n) & 0xff00) >> 8))
    #define FAT_HTONL(n) (((((uint32)(n) & 0xFF)) << 24) | \
                    ((((uint32)(n) & 0xFF00)) << 8) | \
                    ((((uint32)(n) & 0xFF0000)) >> 8) | \
                    ((((uint32)(n) & 0xFF000000)) >> 24))

#endif

//-------------------------------------------------------------
// Structure Packing Compile Options
//-------------------------------------------------------------
#ifdef __GNUC__
    #define STRUCT_PACK
    #define STRUCT_PACK_BEGIN
    #define STRUCT_PACK_END
    #define STRUCT_PACKED           __attribute__ ((packed))
#else
    // Other compilers may require other methods of packing structures
    #define STRUCT_PACK
    #define STRUCT_PACK_BEGIN
    #define STRUCT_PACK_END
    #define STRUCT_PACKED
#endif

#endif
//-----------------------------------------------------------------------------
//            FAT32 Offsets
//        Name                Offset
//-----------------------------------------------------------------------------

// Boot Sector
#define BS_JMPBOOT              0    // Length = 3
#define BS_OEMNAME              3    // Length = 8
#define BPB_BYTSPERSEC          11    // Length = 2
#define BPB_SECPERCLUS          13    // Length = 1
#define BPB_RSVDSECCNT          14    // Length = 2
#define BPB_NUMFATS             16    // Length = 1
#define BPB_ROOTENTCNT          17    // Length = 2
#define BPB_TOTSEC16            19    // Length = 2
#define BPB_MEDIA               21    // Length = 1
#define    BPB_FATSZ16          22    // Length = 2
#define BPB_SECPERTRK           24    // Length = 2
#define BPB_NUMHEADS            26    // Length = 2
#define BPB_HIDDSEC             28    // Length = 4
#define BPB_TOTSEC32            32    // Length = 4

// FAT 12/16
#define BS_FAT_DRVNUM           36    // Length = 1
#define BS_FAT_BOOTSIG          38    // Length = 1
#define BS_FAT_VOLID            39    // Length = 4
#define BS_FAT_VOLLAB           43    // Length = 11
#define BS_FAT_FILSYSTYPE       54    // Length = 8

// FAT 32
#define BPB_FAT32_FATSZ32       36    // Length = 4
#define BPB_FAT32_EXTFLAGS      40    // Length = 2
#define BPB_FAT32_FSVER         42    // Length = 2
#define BPB_FAT32_ROOTCLUS      44    // Length = 4
#define BPB_FAT32_FSINFO        48    // Length = 2
#define BPB_FAT32_BKBOOTSEC     50    // Length = 2
#define BS_FAT32_DRVNUM         64    // Length = 1
#define BS_FAT32_BOOTSIG        66    // Length = 1
#define BS_FAT32_VOLID          67    // Length = 4
#define BS_FAT32_VOLLAB         71    // Length = 11
#define BS_FAT32_FILSYSTYPE     82    // Length = 8

//-----------------------------------------------------------------------------
// FAT Types
//-----------------------------------------------------------------------------
#define FAT_TYPE_FAT12          1
#define FAT_TYPE_FAT16          2
#define FAT_TYPE_FAT32          3

//-----------------------------------------------------------------------------
// FAT32 Specific Statics
//-----------------------------------------------------------------------------
#define SIGNATURE_POSITION              510
#define SIGNATURE_VALUE                 0xAA55
#define PARTITION1_TYPECODE_LOCATION    450
#define FAT32_TYPECODE1                 0x0B
#define FAT32_TYPECODE2                 0x0C
#define PARTITION1_LBA_BEGIN_LOCATION   454
#define PARTITION1_SIZE_LOCATION        458

#define FAT_DIR_ENTRY_SIZE              32
#define FAT_SFN_SIZE_FULL               11
#define FAT_SFN_SIZE_PARTIAL            8

//-----------------------------------------------------------------------------
// FAT32 File Attributes and Types
//-----------------------------------------------------------------------------
#define FILE_ATTR_READ_ONLY             0x01
#define FILE_ATTR_HIDDEN                0x02
#define FILE_ATTR_SYSTEM                0x04
#define FILE_ATTR_SYSHID                0x06
#define FILE_ATTR_VOLUME_ID             0x08
#define FILE_ATTR_DIRECTORY             0x10
#define FILE_ATTR_ARCHIVE               0x20
#define FILE_ATTR_LFN_TEXT              0x0F
#define FILE_HEADER_BLANK               0x00
#define FILE_HEADER_DELETED             0xE5
#define FILE_TYPE_DIR                   0x10
#define FILE_TYPE_FILE                  0x20

//-----------------------------------------------------------------------------
// Time / Date details
//-----------------------------------------------------------------------------
#define FAT_TIME_HOURS_SHIFT            11
#define FAT_TIME_HOURS_MASK             0x1F
#define FAT_TIME_MINUTES_SHIFT          5
#define FAT_TIME_MINUTES_MASK           0x3F
#define FAT_TIME_SECONDS_SHIFT          0
#define FAT_TIME_SECONDS_MASK           0x1F
#define FAT_TIME_SECONDS_SCALE          2
#define FAT_DATE_YEAR_SHIFT             9
#define FAT_DATE_YEAR_MASK              0x7F
#define FAT_DATE_MONTH_SHIFT            5
#define FAT_DATE_MONTH_MASK             0xF
#define FAT_DATE_DAY_SHIFT              0
#define FAT_DATE_DAY_MASK               0x1F
#define FAT_DATE_YEAR_OFFSET            1980

//-----------------------------------------------------------------------------
// Other Defines
//-----------------------------------------------------------------------------
#define FAT32_LAST_CLUSTER              0xFFFFFFFF
#define FAT32_INVALID_CLUSTER           0xFFFFFFFF

STRUCT_PACK_BEGIN
struct fat_dir_entry STRUCT_PACK
{
    uint8 Name[11];
    uint8 Attr;
    uint8 NTRes;
    uint8 CrtTimeTenth;
    uint8 CrtTime[2];
    uint8 CrtDate[2];
    uint8 LstAccDate[2];
    uint16 FstClusHI;
    uint8 WrtTime[2];
    uint8 WrtDate[2];
    uint16 FstClusLO;
    uint32 FileSize;
} STRUCT_PACKED;
STRUCT_PACK_END

#endif

//-----------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------
#define FAT_INIT_OK                         0
#define FAT_INIT_MEDIA_ACCESS_ERROR         (-1)
#define FAT_INIT_INVALID_SECTOR_SIZE        (-2)
#define FAT_INIT_INVALID_SIGNATURE          (-3)
#define FAT_INIT_ENDIAN_ERROR               (-4)
#define FAT_INIT_WRONG_FILESYS_TYPE         (-5)
#define FAT_INIT_WRONG_PARTITION_TYPE       (-6)
#define FAT_INIT_STRUCT_PACKING             (-7)

#define FAT_DIR_ENTRIES_PER_SECTOR          (FAT_SECTOR_SIZE / FAT_DIR_ENTRY_SIZE)

//-----------------------------------------------------------------------------
// Function Pointers
//-----------------------------------------------------------------------------
typedef int (*fn_diskio_read) (uint32 sector, uint8 *buffer, uint32 sector_count);
typedef int (*fn_diskio_write)(uint32 sector, uint8 *buffer, uint32 sector_count);

//-----------------------------------------------------------------------------
// Structures
//-----------------------------------------------------------------------------
struct disk_if
{
    // User supplied function pointers for disk IO
    fn_diskio_read          read_media;
    fn_diskio_write         write_media;
};

// Forward declaration
struct fat_buffer;

struct fat_buffer
{
    uint8                   sector[FAT_SECTOR_SIZE * FAT_BUFFER_SECTORS];
    uint32                  address;
    int                     dirty;
    uint8 *                 ptr;

    // Next in chain of sector buffers
    struct fat_buffer       *next;
};

typedef enum eFatType
{
    FAT_TYPE_16,
    FAT_TYPE_32
} tFatType;

struct fatfs
{
    // Filesystem globals
    uint8                   sectors_per_cluster;
    uint32                  cluster_begin_lba;
    uint32                  rootdir_first_cluster;
    uint32                  rootdir_first_sector;
    uint32                  rootdir_sectors;
    uint32                  fat_begin_lba;
    uint16                  fs_info_sector;
    uint32                  lba_begin;
    uint32                  fat_sectors;
    uint32                  next_free_cluster;
    uint16                  root_entry_count;
    uint16                  reserved_sectors;
    uint8                   num_of_fats;
    tFatType                fat_type;

    // Disk/Media API
    struct disk_if          disk_io;

    // [Optional] Thread Safety
    void                    (*fl_lock)(void);
    void                    (*fl_unlock)(void);

    // Working buffer
    struct fat_buffer        currentsector;

    // FAT Buffer
    struct fat_buffer        *fat_buffer_head;
    struct fat_buffer        fat_buffers[FAT_BUFFERS];
};

struct fs_dir_list_status
{
    uint32                  sector;
    uint32                  cluster;
    uint8                   offset;
};

struct fs_dir_ent
{
    char                    filename[FATFS_MAX_LONG_FILENAME];
    uint8                   is_dir;
    uint32                  cluster;
    uint32                  size;

#if FATFS_INC_TIME_DATE_SUPPORT
    uint16                  access_date;
    uint16                  write_time;
    uint16                  write_date;
    uint16                  create_date;
    uint16                  create_time;
#endif
};

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
int     fatfs_init(struct fatfs *fs);
uint32  fatfs_lba_of_cluster(struct fatfs *fs, uint32 Cluster_Number);
int     fatfs_sector_reader(struct fatfs *fs, uint32 Startcluster, uint32 offset, uint8 *target);
int     fatfs_sector_read(struct fatfs *fs, uint32 lba, uint8 *target, uint32 count);
int     fatfs_sector_write(struct fatfs *fs, uint32 lba, uint8 *target, uint32 count);
int     fatfs_read_sector(struct fatfs *fs, uint32 cluster, uint32 sector, uint8 *target);
int     fatfs_write_sector(struct fatfs *fs, uint32 cluster, uint32 sector, uint8 *target);
void    fatfs_show_details(struct fatfs *fs);
uint32  fatfs_get_root_cluster(struct fatfs *fs);
uint32  fatfs_get_file_entry(struct fatfs *fs, uint32 Cluster, char *nametofind, struct fat_dir_entry *sfEntry);
int     fatfs_sfn_exists(struct fatfs *fs, uint32 Cluster, char *shortname);
int     fatfs_update_file_length(struct fatfs *fs, uint32 Cluster, char *shortname, uint32 fileLength);
int     fatfs_mark_file_deleted(struct fatfs *fs, uint32 Cluster, char *shortname);
void    fatfs_list_directory_start(struct fatfs *fs, struct fs_dir_list_status *dirls, uint32 StartCluster);
int     fatfs_list_directory_next(struct fatfs *fs, struct fs_dir_list_status *dirls, struct fs_dir_ent *entry);
int     fatfs_update_timestamps(struct fat_dir_entry *directoryEntry, int create, int modify, int access);

#endif
#ifndef __FAT_CACHE_H__
#define __FAT_CACHE_H__


#ifndef __FAT_FILELIB_H__
#define __FAT_FILELIB_H__

#ifndef __FAT_LIST_H__
#define __FAT_LIST_H__

#ifndef FAT_ASSERT
    #define FAT_ASSERT(x)
#endif

#ifndef FAT_INLINE
    #define FAT_INLINE
#endif

//-----------------------------------------------------------------
// Types
//-----------------------------------------------------------------
struct fat_list;

struct fat_node
{
    struct fat_node    *previous;
    struct fat_node    *next;
};

struct fat_list
{
    struct fat_node    *head;
    struct fat_node    *tail;
};

//-----------------------------------------------------------------
// Macros
//-----------------------------------------------------------------
#define fat_list_entry(p, t, m)     p ? ((t *)((char *)(p)-(char*)(&((t *)0)->m))) : 0
#define fat_list_next(l, p)         (p)->next
#define fat_list_prev(l, p)         (p)->previous
#define fat_list_first(l)           (l)->head
#define fat_list_last(l)            (l)->tail
#define fat_list_for_each(l, p)     for ((p) = (l)->head; (p); (p) = (p)->next)

//-----------------------------------------------------------------
// Inline Functions
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// fat_list_init:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_init(struct fat_list *list)
{
    FAT_ASSERT(list);

    list->head = list->tail = 0;
}
//-----------------------------------------------------------------
// fat_list_remove:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_remove(struct fat_list *list, struct fat_node *node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);

    if(!node->previous)
        list->head = node->next;
    else
        node->previous->next = node->next;

    if(!node->next)
        list->tail = node->previous;
    else
        node->next->previous = node->previous;
}
//-----------------------------------------------------------------
// fat_list_insert_after:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_after(struct fat_list *list, struct fat_node *node, struct fat_node *new_node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);
    FAT_ASSERT(new_node);

    new_node->previous = node;
    new_node->next = node->next;
    if (!node->next)
        list->tail = new_node;
    else
        node->next->previous = new_node;
    node->next = new_node;
}
//-----------------------------------------------------------------
// fat_list_insert_before:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_before(struct fat_list *list, struct fat_node *node, struct fat_node *new_node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);
    FAT_ASSERT(new_node);

    new_node->previous = node->previous;
    new_node->next = node;
    if (!node->previous)
        list->head = new_node;
    else
        node->previous->next = new_node;
    node->previous = new_node;
}
//-----------------------------------------------------------------
// fat_list_insert_first:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_first(struct fat_list *list, struct fat_node *node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);

    if (!list->head)
    {
        list->head = node;
        list->tail = node;
        node->previous = 0;
        node->next = 0;
    }
    else
        fat_list_insert_before(list, list->head, node);
}
//-----------------------------------------------------------------
// fat_list_insert_last:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_last(struct fat_list *list, struct fat_node *node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);

    if (!list->tail)
        fat_list_insert_first(list, node);
     else
        fat_list_insert_after(list, list->tail, node);
}
//-----------------------------------------------------------------
// fat_list_is_empty:
//-----------------------------------------------------------------
static FAT_INLINE int fat_list_is_empty(struct fat_list *list)
{
    FAT_ASSERT(list);

    return !list->head;
}
//-----------------------------------------------------------------
// fat_list_pop_head:
//-----------------------------------------------------------------
static FAT_INLINE struct fat_node * fat_list_pop_head(struct fat_list *list)
{
    struct fat_node * node;

    FAT_ASSERT(list);

    node = fat_list_first(list);
    if (node)
        fat_list_remove(list, node);

    return node;
}

#endif

//-----------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------
#ifndef SEEK_CUR
    #define SEEK_CUR    1
#endif

#ifndef SEEK_END
    #define SEEK_END    2
#endif

#ifndef SEEK_SET
    #define SEEK_SET    0
#endif

#ifndef EOF
    #define EOF         (-1)
#endif

//-----------------------------------------------------------------------------
// Structures
//-----------------------------------------------------------------------------
struct sFL_FILE;

struct cluster_lookup
{
    uint32 ClusterIdx;
    uint32 CurrentCluster;
};

typedef struct sFL_FILE
{
    uint32                  parentcluster;
    uint32                  startcluster;
    uint32                  bytenum;
    uint32                  filelength;
    int                     filelength_changed;
    char                    path[FATFS_MAX_LONG_FILENAME];
    char                    filename[FATFS_MAX_LONG_FILENAME];
    uint8                   shortfilename[11];

#ifdef FAT_CLUSTER_CACHE_ENTRIES
    uint32                  cluster_cache_idx[FAT_CLUSTER_CACHE_ENTRIES];
    uint32                  cluster_cache_data[FAT_CLUSTER_CACHE_ENTRIES];
#endif

    // Cluster Lookup
    struct cluster_lookup   last_fat_lookup;

    // Read/Write sector buffer
    uint8                   file_data_sector[FAT_SECTOR_SIZE];
    uint32                  file_data_address;
    int                     file_data_dirty;

    // File fopen flags
    uint8                   flags;
#define FILE_READ           (1 << 0)
#define FILE_WRITE          (1 << 1)
#define FILE_APPEND         (1 << 2)
#define FILE_BINARY         (1 << 3)
#define FILE_ERASE          (1 << 4)
#define FILE_CREATE         (1 << 5)

    struct fat_node         list_node;
} FL_FILE;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------

// External
void                fl_init(void);
void                fl_attach_locks(void (*lock)(void), void (*unlock)(void));
int                 fl_attach_media(fn_diskio_read rd, fn_diskio_write wr);
void                fl_shutdown(void);

// Standard API
void*               fl_fopen(const char *path, const char *modifiers);
void                fl_fclose(void *file);
int                 fl_fflush(void *file);
int                 fl_fgetc(void *file);
char *              fl_fgets(char *s, int n, void *f);
int                 fl_fputc(int c, void *file);
int                 fl_fputs(const char * str, void *file);
int                 fl_fwrite(const void * data, int size, int count, void *file );
int                 fl_fread(void * data, int size, int count, void *file );
int                 fl_fseek(void *file , long offset , int origin );
int                 fl_fgetpos(void *file , uint32 * position);
long                fl_ftell(void *f);
int                 fl_feof(void *f);
int                 fl_remove(const char * filename);

// Equivelant dirent.h
typedef struct fs_dir_list_status    FL_DIR;
typedef struct fs_dir_ent            fl_dirent;

FL_DIR*             fl_opendir(const char* path, FL_DIR *dir);
int                 fl_readdir(FL_DIR *dirls, fl_dirent *entry);
int                 fl_closedir(FL_DIR* dir);

// Extensions
void                fl_listdirectory(const char *path);
int                 fl_createdirectory(const char *path);
int                 fl_is_dir(const char *path);

int                 fl_format(uint32 volume_sectors, const char *name);

// Test hooks
#ifdef FATFS_INC_TEST_HOOKS
struct fatfs*       fl_get_fs(void);
#endif

//-----------------------------------------------------------------------------
// Stdio file I/O names
//-----------------------------------------------------------------------------
#ifdef USE_FILELIB_STDIO_COMPAT_NAMES

#define FILE            FL_FILE

#define fopen(a,b)      fl_fopen(a, b)
#define fclose(a)       fl_fclose(a)
#define fflush(a)       fl_fflush(a)
#define fgetc(a)        fl_fgetc(a)
#define fgets(a,b,c)    fl_fgets(a, b, c)
#define fputc(a,b)      fl_fputc(a, b)
#define fputs(a,b)      fl_fputs(a, b)
#define fwrite(a,b,c,d) fl_fwrite(a, b, c, d)
#define fread(a,b,c,d)  fl_fread(a, b, c, d)
#define fseek(a,b,c)    fl_fseek(a, b, c)
#define fgetpos(a,b)    fl_fgetpos(a, b)
#define ftell(a)        fl_ftell(a)
#define feof(a)         fl_feof(a)
#define remove(a)       fl_remove(a)
#define mkdir(a)        fl_createdirectory(a)
#define rmdir(a)        0

#endif

#endif
//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
int fatfs_cache_init(struct fatfs *fs, FL_FILE *file);
int fatfs_cache_get_next_cluster(struct fatfs *fs, FL_FILE *file, uint32 clusterIdx, uint32 *pNextCluster);
int fatfs_cache_set_next_cluster(struct fatfs *fs, FL_FILE *file, uint32 clusterIdx, uint32 nextCluster);

#endif
#ifndef __FAT_DEFS_H__
#define __FAT_DEFS_H__

//-----------------------------------------------------------------------------
//            FAT32 Offsets
//        Name                Offset
//-----------------------------------------------------------------------------

// Boot Sector
#define BS_JMPBOOT              0    // Length = 3
#define BS_OEMNAME              3    // Length = 8
#define BPB_BYTSPERSEC          11    // Length = 2
#define BPB_SECPERCLUS          13    // Length = 1
#define BPB_RSVDSECCNT          14    // Length = 2
#define BPB_NUMFATS             16    // Length = 1
#define BPB_ROOTENTCNT          17    // Length = 2
#define BPB_TOTSEC16            19    // Length = 2
#define BPB_MEDIA               21    // Length = 1
#define    BPB_FATSZ16          22    // Length = 2
#define BPB_SECPERTRK           24    // Length = 2
#define BPB_NUMHEADS            26    // Length = 2
#define BPB_HIDDSEC             28    // Length = 4
#define BPB_TOTSEC32            32    // Length = 4

// FAT 12/16
#define BS_FAT_DRVNUM           36    // Length = 1
#define BS_FAT_BOOTSIG          38    // Length = 1
#define BS_FAT_VOLID            39    // Length = 4
#define BS_FAT_VOLLAB           43    // Length = 11
#define BS_FAT_FILSYSTYPE       54    // Length = 8

// FAT 32
#define BPB_FAT32_FATSZ32       36    // Length = 4
#define BPB_FAT32_EXTFLAGS      40    // Length = 2
#define BPB_FAT32_FSVER         42    // Length = 2
#define BPB_FAT32_ROOTCLUS      44    // Length = 4
#define BPB_FAT32_FSINFO        48    // Length = 2
#define BPB_FAT32_BKBOOTSEC     50    // Length = 2
#define BS_FAT32_DRVNUM         64    // Length = 1
#define BS_FAT32_BOOTSIG        66    // Length = 1
#define BS_FAT32_VOLID          67    // Length = 4
#define BS_FAT32_VOLLAB         71    // Length = 11
#define BS_FAT32_FILSYSTYPE     82    // Length = 8

//-----------------------------------------------------------------------------
// FAT Types
//-----------------------------------------------------------------------------
#define FAT_TYPE_FAT12          1
#define FAT_TYPE_FAT16          2
#define FAT_TYPE_FAT32          3

//-----------------------------------------------------------------------------
// FAT32 Specific Statics
//-----------------------------------------------------------------------------
#define SIGNATURE_POSITION              510
#define SIGNATURE_VALUE                 0xAA55
#define PARTITION1_TYPECODE_LOCATION    450
#define FAT32_TYPECODE1                 0x0B
#define FAT32_TYPECODE2                 0x0C
#define PARTITION1_LBA_BEGIN_LOCATION   454
#define PARTITION1_SIZE_LOCATION        458

#define FAT_DIR_ENTRY_SIZE              32
#define FAT_SFN_SIZE_FULL               11
#define FAT_SFN_SIZE_PARTIAL            8

//-----------------------------------------------------------------------------
// FAT32 File Attributes and Types
//-----------------------------------------------------------------------------
#define FILE_ATTR_READ_ONLY             0x01
#define FILE_ATTR_HIDDEN                0x02
#define FILE_ATTR_SYSTEM                0x04
#define FILE_ATTR_SYSHID                0x06
#define FILE_ATTR_VOLUME_ID             0x08
#define FILE_ATTR_DIRECTORY             0x10
#define FILE_ATTR_ARCHIVE               0x20
#define FILE_ATTR_LFN_TEXT              0x0F
#define FILE_HEADER_BLANK               0x00
#define FILE_HEADER_DELETED             0xE5
#define FILE_TYPE_DIR                   0x10
#define FILE_TYPE_FILE                  0x20

//-----------------------------------------------------------------------------
// Time / Date details
//-----------------------------------------------------------------------------
#define FAT_TIME_HOURS_SHIFT            11
#define FAT_TIME_HOURS_MASK             0x1F
#define FAT_TIME_MINUTES_SHIFT          5
#define FAT_TIME_MINUTES_MASK           0x3F
#define FAT_TIME_SECONDS_SHIFT          0
#define FAT_TIME_SECONDS_MASK           0x1F
#define FAT_TIME_SECONDS_SCALE          2
#define FAT_DATE_YEAR_SHIFT             9
#define FAT_DATE_YEAR_MASK              0x7F
#define FAT_DATE_MONTH_SHIFT            5
#define FAT_DATE_MONTH_MASK             0xF
#define FAT_DATE_DAY_SHIFT              0
#define FAT_DATE_DAY_MASK               0x1F
#define FAT_DATE_YEAR_OFFSET            1980

//-----------------------------------------------------------------------------
// Other Defines
//-----------------------------------------------------------------------------
#define FAT32_LAST_CLUSTER              0xFFFFFFFF
#define FAT32_INVALID_CLUSTER           0xFFFFFFFF

STRUCT_PACK_BEGIN
struct fat_dir_entry STRUCT_PACK
{
    uint8 Name[11];
    uint8 Attr;
    uint8 NTRes;
    uint8 CrtTimeTenth;
    uint8 CrtTime[2];
    uint8 CrtDate[2];
    uint8 LstAccDate[2];
    uint16 FstClusHI;
    uint8 WrtTime[2];
    uint8 WrtDate[2];
    uint16 FstClusLO;
    uint32 FileSize;
} STRUCT_PACKED;
STRUCT_PACK_END

#endif
#ifndef __FAT_FILELIB_H__
#define __FAT_FILELIB_H__


//-----------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------
#ifndef SEEK_CUR
    #define SEEK_CUR    1
#endif

#ifndef SEEK_END
    #define SEEK_END    2
#endif

#ifndef SEEK_SET
    #define SEEK_SET    0
#endif

#ifndef EOF
    #define EOF         (-1)
#endif

//-----------------------------------------------------------------------------
// Structures
//-----------------------------------------------------------------------------
struct sFL_FILE;

struct cluster_lookup
{
    uint32 ClusterIdx;
    uint32 CurrentCluster;
};

typedef struct sFL_FILE
{
    uint32                  parentcluster;
    uint32                  startcluster;
    uint32                  bytenum;
    uint32                  filelength;
    int                     filelength_changed;
    char                    path[FATFS_MAX_LONG_FILENAME];
    char                    filename[FATFS_MAX_LONG_FILENAME];
    uint8                   shortfilename[11];

#ifdef FAT_CLUSTER_CACHE_ENTRIES
    uint32                  cluster_cache_idx[FAT_CLUSTER_CACHE_ENTRIES];
    uint32                  cluster_cache_data[FAT_CLUSTER_CACHE_ENTRIES];
#endif

    // Cluster Lookup
    struct cluster_lookup   last_fat_lookup;

    // Read/Write sector buffer
    uint8                   file_data_sector[FAT_SECTOR_SIZE];
    uint32                  file_data_address;
    int                     file_data_dirty;

    // File fopen flags
    uint8                   flags;
#define FILE_READ           (1 << 0)
#define FILE_WRITE          (1 << 1)
#define FILE_APPEND         (1 << 2)
#define FILE_BINARY         (1 << 3)
#define FILE_ERASE          (1 << 4)
#define FILE_CREATE         (1 << 5)

    struct fat_node         list_node;
} FL_FILE;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------

// External
void                fl_init(void);
void                fl_attach_locks(void (*lock)(void), void (*unlock)(void));
int                 fl_attach_media(fn_diskio_read rd, fn_diskio_write wr);
void                fl_shutdown(void);

// Standard API
void*               fl_fopen(const char *path, const char *modifiers);
void                fl_fclose(void *file);
int                 fl_fflush(void *file);
int                 fl_fgetc(void *file);
char *              fl_fgets(char *s, int n, void *f);
int                 fl_fputc(int c, void *file);
int                 fl_fputs(const char * str, void *file);
int                 fl_fwrite(const void * data, int size, int count, void *file );
int                 fl_fread(void * data, int size, int count, void *file );
int                 fl_fseek(void *file , long offset , int origin );
int                 fl_fgetpos(void *file , uint32 * position);
long                fl_ftell(void *f);
int                 fl_feof(void *f);
int                 fl_remove(const char * filename);

// Equivelant dirent.h
typedef struct fs_dir_list_status    FL_DIR;
typedef struct fs_dir_ent            fl_dirent;

FL_DIR*             fl_opendir(const char* path, FL_DIR *dir);
int                 fl_readdir(FL_DIR *dirls, fl_dirent *entry);
int                 fl_closedir(FL_DIR* dir);

// Extensions
void                fl_listdirectory(const char *path);
int                 fl_createdirectory(const char *path);
int                 fl_is_dir(const char *path);

int                 fl_format(uint32 volume_sectors, const char *name);

// Test hooks
#ifdef FATFS_INC_TEST_HOOKS
struct fatfs*       fl_get_fs(void);
#endif

//-----------------------------------------------------------------------------
// Stdio file I/O names
//-----------------------------------------------------------------------------
#ifdef USE_FILELIB_STDIO_COMPAT_NAMES

#define FILE            FL_FILE

#define fopen(a,b)      fl_fopen(a, b)
#define fclose(a)       fl_fclose(a)
#define fflush(a)       fl_fflush(a)
#define fgetc(a)        fl_fgetc(a)
#define fgets(a,b,c)    fl_fgets(a, b, c)
#define fputc(a,b)      fl_fputc(a, b)
#define fputs(a,b)      fl_fputs(a, b)
#define fwrite(a,b,c,d) fl_fwrite(a, b, c, d)
#define fread(a,b,c,d)  fl_fread(a, b, c, d)
#define fseek(a,b,c)    fl_fseek(a, b, c)
#define fgetpos(a,b)    fl_fgetpos(a, b)
#define ftell(a)        fl_ftell(a)
#define feof(a)         fl_feof(a)
#define remove(a)       fl_remove(a)
#define mkdir(a)        fl_createdirectory(a)
#define rmdir(a)        0

#endif

#endif
#ifndef __FAT_FORMAT_H__
#define __FAT_FORMAT_H__


//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
int fatfs_format(struct fatfs *fs, uint32 volume_sectors, const char *name);
int fatfs_format_fat16(struct fatfs *fs, uint32 volume_sectors, const char *name);
int fatfs_format_fat32(struct fatfs *fs, uint32 volume_sectors, const char *name);

#endif
#ifndef __FAT_LIST_H__
#define __FAT_LIST_H__

#ifndef FAT_ASSERT
    #define FAT_ASSERT(x)
#endif

#ifndef FAT_INLINE
    #define FAT_INLINE
#endif

//-----------------------------------------------------------------
// Types
//-----------------------------------------------------------------
struct fat_list;

struct fat_node
{
    struct fat_node    *previous;
    struct fat_node    *next;
};

struct fat_list
{
    struct fat_node    *head;
    struct fat_node    *tail;
};

//-----------------------------------------------------------------
// Macros
//-----------------------------------------------------------------
#define fat_list_entry(p, t, m)     p ? ((t *)((char *)(p)-(char*)(&((t *)0)->m))) : 0
#define fat_list_next(l, p)         (p)->next
#define fat_list_prev(l, p)         (p)->previous
#define fat_list_first(l)           (l)->head
#define fat_list_last(l)            (l)->tail
#define fat_list_for_each(l, p)     for ((p) = (l)->head; (p); (p) = (p)->next)

//-----------------------------------------------------------------
// Inline Functions
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// fat_list_init:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_init(struct fat_list *list)
{
    FAT_ASSERT(list);

    list->head = list->tail = 0;
}
//-----------------------------------------------------------------
// fat_list_remove:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_remove(struct fat_list *list, struct fat_node *node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);

    if(!node->previous)
        list->head = node->next;
    else
        node->previous->next = node->next;

    if(!node->next)
        list->tail = node->previous;
    else
        node->next->previous = node->previous;
}
//-----------------------------------------------------------------
// fat_list_insert_after:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_after(struct fat_list *list, struct fat_node *node, struct fat_node *new_node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);
    FAT_ASSERT(new_node);

    new_node->previous = node;
    new_node->next = node->next;
    if (!node->next)
        list->tail = new_node;
    else
        node->next->previous = new_node;
    node->next = new_node;
}
//-----------------------------------------------------------------
// fat_list_insert_before:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_before(struct fat_list *list, struct fat_node *node, struct fat_node *new_node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);
    FAT_ASSERT(new_node);

    new_node->previous = node->previous;
    new_node->next = node;
    if (!node->previous)
        list->head = new_node;
    else
        node->previous->next = new_node;
    node->previous = new_node;
}
//-----------------------------------------------------------------
// fat_list_insert_first:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_first(struct fat_list *list, struct fat_node *node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);

    if (!list->head)
    {
        list->head = node;
        list->tail = node;
        node->previous = 0;
        node->next = 0;
    }
    else
        fat_list_insert_before(list, list->head, node);
}
//-----------------------------------------------------------------
// fat_list_insert_last:
//-----------------------------------------------------------------
static FAT_INLINE void fat_list_insert_last(struct fat_list *list, struct fat_node *node)
{
    FAT_ASSERT(list);
    FAT_ASSERT(node);

    if (!list->tail)
        fat_list_insert_first(list, node);
     else
        fat_list_insert_after(list, list->tail, node);
}
//-----------------------------------------------------------------
// fat_list_is_empty:
//-----------------------------------------------------------------
static FAT_INLINE int fat_list_is_empty(struct fat_list *list)
{
    FAT_ASSERT(list);

    return !list->head;
}
//-----------------------------------------------------------------
// fat_list_pop_head:
//-----------------------------------------------------------------
static FAT_INLINE struct fat_node * fat_list_pop_head(struct fat_list *list)
{
    struct fat_node * node;

    FAT_ASSERT(list);

    node = fat_list_first(list);
    if (node)
        fat_list_remove(list, node);

    return node;
}

#endif

#ifndef __FAT_MISC_H__
#define __FAT_MISC_H__

//-----------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------
#define MAX_LONGFILENAME_ENTRIES    20
#define MAX_LFN_ENTRY_LENGTH        13

//-----------------------------------------------------------------------------
// Macros
//-----------------------------------------------------------------------------
#define GET_32BIT_WORD(buffer, location)    ( ((uint32)buffer[location+3]<<24) + ((uint32)buffer[location+2]<<16) + ((uint32)buffer[location+1]<<8) + (uint32)buffer[location+0] )
#define GET_16BIT_WORD(buffer, location)    ( ((uint16)buffer[location+1]<<8) + (uint16)buffer[location+0] )

#define SET_32BIT_WORD(buffer, location, value)    { buffer[location+0] = (uint8)((value)&0xFF); \
                                                  buffer[location+1] = (uint8)((value>>8)&0xFF); \
                                                  buffer[location+2] = (uint8)((value>>16)&0xFF); \
                                                  buffer[location+3] = (uint8)((value>>24)&0xFF); }

#define SET_16BIT_WORD(buffer, location, value)    { buffer[location+0] = (uint8)((value)&0xFF); \
                                                  buffer[location+1] = (uint8)((value>>8)&0xFF); }

//-----------------------------------------------------------------------------
// Structures
//-----------------------------------------------------------------------------
struct lfn_cache
{
#if FATFS_INC_LFN_SUPPORT
    // Long File Name Structure (max 260 LFN length)
    uint8 String[MAX_LONGFILENAME_ENTRIES][MAX_LFN_ENTRY_LENGTH];
    uint8 Null;
#endif
    uint8 no_of_strings;
};

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
void    fatfs_lfn_cache_init(struct lfn_cache *lfn, int wipeTable);
void    fatfs_lfn_cache_entry(struct lfn_cache *lfn, uint8 *entryBuffer);
char*   fatfs_lfn_cache_get(struct lfn_cache *lfn);
int     fatfs_entry_lfn_text(struct fat_dir_entry *entry);
int     fatfs_entry_lfn_invalid(struct fat_dir_entry *entry);
int     fatfs_entry_lfn_exists(struct lfn_cache *lfn, struct fat_dir_entry *entry);
int     fatfs_entry_sfn_only(struct fat_dir_entry *entry);
int     fatfs_entry_is_dir(struct fat_dir_entry *entry);
int     fatfs_entry_is_file(struct fat_dir_entry *entry);
int     fatfs_lfn_entries_required(char *filename);
void    fatfs_filename_to_lfn(char *filename, uint8 *buffer, int entry, uint8 sfnChk);
void    fatfs_sfn_create_entry(char *shortfilename, uint32 size, uint32 startCluster, struct fat_dir_entry *entry, int dir);
int     fatfs_lfn_create_sfn(char *sfn_output, char *filename);
int     fatfs_lfn_generate_tail(char *sfn_output, char *sfn_input, uint32 tailNum);
void    fatfs_convert_from_fat_time(uint16 fat_time, int *hours, int *minutes, int *seconds);
void    fatfs_convert_from_fat_date(uint16 fat_date, int *day, int *month, int *year);
uint16  fatfs_convert_to_fat_time(int hours, int minutes, int seconds);
uint16  fatfs_convert_to_fat_date(int day, int month, int year);
void    fatfs_print_sector(uint32 sector, uint8 *data);

#endif
#ifndef __FAT_OPTS_H__
#define __FAT_OPTS_H__

#ifdef FATFS_USE_CUSTOM_OPTS_FILE
    #include "fat_custom.h"
#endif

//-------------------------------------------------------------
// Configuration
//-------------------------------------------------------------

// Is the processor little endian (1) or big endian (0)
#ifndef FATFS_IS_LITTLE_ENDIAN
    #define FATFS_IS_LITTLE_ENDIAN          1
#endif

// Max filename Length
#ifndef FATFS_MAX_LONG_FILENAME
    #define FATFS_MAX_LONG_FILENAME         260
#endif

// Max open files (reduce to lower memory requirements)
#ifndef FATFS_MAX_OPEN_FILES
    #define FATFS_MAX_OPEN_FILES            2
#endif

// Number of sectors per FAT_BUFFER (min 1)
#ifndef FAT_BUFFER_SECTORS
    #define FAT_BUFFER_SECTORS              1
#endif

// Max FAT sectors to buffer (min 1)
// (mem used is FAT_BUFFERS * FAT_BUFFER_SECTORS * FAT_SECTOR_SIZE)
#ifndef FAT_BUFFERS
    #define FAT_BUFFERS                     1
#endif

// Size of cluster chain cache (can be undefined)
// Mem used = FAT_CLUSTER_CACHE_ENTRIES * 4 * 2
// Improves access speed considerably
//#define FAT_CLUSTER_CACHE_ENTRIES         128

// Include support for writing files (1 / 0)?
#ifndef FATFS_INC_WRITE_SUPPORT
    #define FATFS_INC_WRITE_SUPPORT         1
#endif

// Support long filenames (1 / 0)?
// (if not (0) only 8.3 format is supported)
#ifndef FATFS_INC_LFN_SUPPORT
    #define FATFS_INC_LFN_SUPPORT           1
#endif

// Support directory listing (1 / 0)?
#ifndef FATFS_DIR_LIST_SUPPORT
    #define FATFS_DIR_LIST_SUPPORT          1
#endif

// Support time/date (1 / 0)?
#ifndef FATFS_INC_TIME_DATE_SUPPORT
    #define FATFS_INC_TIME_DATE_SUPPORT     0
#endif

// Include support for formatting disks (1 / 0)?
#ifndef FATFS_INC_FORMAT_SUPPORT
    #define FATFS_INC_FORMAT_SUPPORT        1
#endif

// Sector size used
#define FAT_SECTOR_SIZE                     512

// Printf output (directory listing / debug)
#ifndef FAT_PRINTF
    // Don't include stdio, but there is a printf function available
    #ifdef FAT_PRINTF_NOINC_STDIO
        extern int printf(const char* ctrl1, ... );
        #define FAT_PRINTF(a)               printf a
    // Include stdio to use printf
    #else
        #include "stdlib.c"
        #define FAT_PRINTF(a)               printf a
    #endif
#endif

// Time/Date support requires time.h
#if FATFS_INC_TIME_DATE_SUPPORT
    #include <time.h>
#endif

#endif
#ifndef __FILESTRING_H__
#define __FILESTRING_H__

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
int fatfs_total_path_levels(char *path);
int fatfs_get_substring(char *Path, int levelreq, char *output, int max_len);
int fatfs_split_path(char *FullPath, char *Path, int max_path, char *FileName, int max_filename);
int fatfs_compare_names(char* strA, char* strB);
int fatfs_string_ends_with_slash(char *path);
int fatfs_get_sfn_display_name(char* out, char* in);
int fatfs_get_extension(char* filename, char* out, int maxlen);
int fatfs_create_path_string(char* path, char *filename, char* out, int maxlen);

#ifndef NULL
    #define NULL 0
#endif

#endif
#ifndef __FAT_TABLE_H__
#define __FAT_TABLE_H__

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
void    fatfs_fat_init(struct fatfs *fs);
int     fatfs_fat_purge(struct fatfs *fs);
uint32  fatfs_find_next_cluster(struct fatfs *fs, uint32 current_cluster);
void    fatfs_set_fs_info_next_free_cluster(struct fatfs *fs, uint32 newValue);
int     fatfs_find_blank_cluster(struct fatfs *fs, uint32 start_cluster, uint32 *free_cluster);
int     fatfs_fat_set_cluster(struct fatfs *fs, uint32 cluster, uint32 next_cluster);
int     fatfs_fat_add_cluster_to_chain(struct fatfs *fs, uint32 start_cluster, uint32 newEntry);
int     fatfs_free_cluster_chain(struct fatfs *fs, uint32 start_cluster);
uint32  fatfs_count_free_clusters(struct fatfs *fs);

#endif
#ifndef __FAT_TYPES_H__
#define __FAT_TYPES_H__

// Detect 64-bit compilation on GCC
#if defined(__GNUC__) && defined(__SIZEOF_LONG__)
    #if __SIZEOF_LONG__ == 8
        #define FATFS_DEF_UINT32_AS_INT
    #endif
#endif

//-------------------------------------------------------------
// System specific types
//-------------------------------------------------------------
#ifndef FATFS_NO_DEF_TYPES
    typedef unsigned char uint8;
    typedef unsigned short uint16;

    // If compiling on a 64-bit machine, use int as 32-bits
    #ifdef FATFS_DEF_UINT32_AS_INT
        typedef unsigned int uint32;
    // Else for 32-bit machines & embedded systems, use long...
    #else
        typedef unsigned long uint32;
    #endif
#endif

#ifndef NULL
    #define NULL 0
#endif

//-------------------------------------------------------------
// Endian Macros
//-------------------------------------------------------------
// FAT is little endian so big endian systems need to swap words

// Little Endian - No swap required
#if FATFS_IS_LITTLE_ENDIAN == 1

    #define FAT_HTONS(n) (n)
    #define FAT_HTONL(n) (n)

// Big Endian - Swap required
#else

    #define FAT_HTONS(n) ((((uint16)((n) & 0xff)) << 8) | (((n) & 0xff00) >> 8))
    #define FAT_HTONL(n) (((((uint32)(n) & 0xFF)) << 24) | \
                    ((((uint32)(n) & 0xFF00)) << 8) | \
                    ((((uint32)(n) & 0xFF0000)) >> 8) | \
                    ((((uint32)(n) & 0xFF000000)) >> 24))

#endif

//-------------------------------------------------------------
// Structure Packing Compile Options
//-------------------------------------------------------------
#ifdef __GNUC__
    #define STRUCT_PACK
    #define STRUCT_PACK_BEGIN
    #define STRUCT_PACK_END
    #define STRUCT_PACKED           __attribute__ ((packed))
#else
    // Other compilers may require other methods of packing structures
    #define STRUCT_PACK
    #define STRUCT_PACK_BEGIN
    #define STRUCT_PACK_END
    #define STRUCT_PACKED
#endif

#endif
#ifndef __FAT_WRITE_H__
#define __FAT_WRITE_H__

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
int fatfs_add_file_entry(struct fatfs *fs, uint32 dirCluster, char *filename, char *shortfilename, uint32 startCluster, uint32 size, int dir);
int fatfs_add_free_space(struct fatfs *fs, uint32 *startCluster, uint32 clusters);
int fatfs_allocate_free_space(struct fatfs *fs, int newFile, uint32 *startCluster, uint32 size);

#endif

#ifndef __TIMER_H__
#define __TIMER_H__

//-----------------------------------------------------------------
// Types
//-----------------------------------------------------------------
typedef unsigned long   t_time;

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------

// General timer
void            timer_init(void);
t_time          timer_now(void);
static long     timer_diff(t_time a, t_time b) { return (long)(a - b); } 
void            timer_sleep(int timeMs);

#endif

#ifndef __SPI_H__
#define __SPI_H__

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------
void      spi_init(void);
void      spi_cs(uint32_t value);
uint8_t   spi_sendrecv(uint8_t ch);
void      spi_readblock(uint8_t *ptr, int length);
void      spi_writeblock(uint8_t *ptr, int length);

#endif

#ifndef __SD_H__
#define __SD_H__


//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------

// sd_init: Return 0 on success, non zero of failure 
int sd_init(void);

// sd_writesector: Return 1 on success, 0 on failure
int sd_writesector(uint32_t sector, uint8_t *buffer, uint32_t sector_count);

// sd_readsector: Return 1 on success, 0 on failure
int sd_readsector(uint32_t sector, uint8_t *buffer, uint32_t sector_count);

#endif
#include "kianv_spi_bitbang.h"
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// fatfs_init: Load FAT Parameters
//-----------------------------------------------------------------------------
int fatfs_init(struct fatfs *fs)
{
    uint8 num_of_fats;
    uint16 reserved_sectors;
    uint32 FATSz;
    uint32 root_dir_sectors;
    uint32 total_sectors;
    uint32 data_sectors;
    uint32 count_of_clusters;
    uint8 valid_partition = 0;

    fs->currentsector.address = FAT32_INVALID_CLUSTER;
    fs->currentsector.dirty = 0;

    fs->next_free_cluster = 0; // Invalid

    fatfs_fat_init(fs);

    // Make sure we have a read function (write function is optional)
    if (!fs->disk_io.read_media)
        return FAT_INIT_MEDIA_ACCESS_ERROR;

    // MBR: Sector 0 on the disk
    // NOTE: Some removeable media does not have this.

    // Load MBR (LBA 0) into the 512 byte buffer
    if (!fs->disk_io.read_media(0, fs->currentsector.sector, 1))
        return FAT_INIT_MEDIA_ACCESS_ERROR;

    // Make Sure 0x55 and 0xAA are at end of sector
    // (this should be the case regardless of the MBR or boot sector)
    if (fs->currentsector.sector[SIGNATURE_POSITION] != 0x55 || fs->currentsector.sector[SIGNATURE_POSITION+1] != 0xAA)
        return FAT_INIT_INVALID_SIGNATURE;

    // Now check again using the access function to prove endian conversion function
    if (GET_16BIT_WORD(fs->currentsector.sector, SIGNATURE_POSITION) != SIGNATURE_VALUE)
        return FAT_INIT_ENDIAN_ERROR;

    // Verify packed structures
    if (sizeof(struct fat_dir_entry) != FAT_DIR_ENTRY_SIZE)
        return FAT_INIT_STRUCT_PACKING;

    // Check the partition type code
    switch(fs->currentsector.sector[PARTITION1_TYPECODE_LOCATION])
    {
        case 0x0B:
        case 0x06:
        case 0x0C:
        case 0x0E:
        case 0x0F:
        case 0x05:
            valid_partition = 1;
        break;
        case 0x00:
            valid_partition = 0;
            break;
        default:
            if (fs->currentsector.sector[PARTITION1_TYPECODE_LOCATION] <= 0x06)
                valid_partition = 1;
        break;
    }

    // Read LBA Begin for the file system
    if (valid_partition)
        fs->lba_begin = GET_32BIT_WORD(fs->currentsector.sector, PARTITION1_LBA_BEGIN_LOCATION);
    // Else possibly MBR less disk
    else
        fs->lba_begin = 0;

    // Load Volume 1 table into sector buffer
    // (We may already have this in the buffer if MBR less drive!)
    if (!fs->disk_io.read_media(fs->lba_begin, fs->currentsector.sector, 1))
        return FAT_INIT_MEDIA_ACCESS_ERROR;

    // Make sure there are 512 bytes per cluster
    if (GET_16BIT_WORD(fs->currentsector.sector, 0x0B) != FAT_SECTOR_SIZE)
        return FAT_INIT_INVALID_SECTOR_SIZE;

    // Load Parameters of FAT partition
    fs->sectors_per_cluster = fs->currentsector.sector[BPB_SECPERCLUS];
    reserved_sectors = GET_16BIT_WORD(fs->currentsector.sector, BPB_RSVDSECCNT);
    num_of_fats = fs->currentsector.sector[BPB_NUMFATS];
    fs->root_entry_count = GET_16BIT_WORD(fs->currentsector.sector, BPB_ROOTENTCNT);

    if(GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16) != 0)
        fs->fat_sectors = GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16);
    else
        fs->fat_sectors = GET_32BIT_WORD(fs->currentsector.sector, BPB_FAT32_FATSZ32);

    // For FAT32 (which this may be)
    fs->rootdir_first_cluster = GET_32BIT_WORD(fs->currentsector.sector, BPB_FAT32_ROOTCLUS);
    fs->fs_info_sector = GET_16BIT_WORD(fs->currentsector.sector, BPB_FAT32_FSINFO);

    // For FAT16 (which this may be), rootdir_first_cluster is actuall rootdir_first_sector
    fs->rootdir_first_sector = reserved_sectors + (num_of_fats * fs->fat_sectors);
    fs->rootdir_sectors = ((fs->root_entry_count * 32) + (FAT_SECTOR_SIZE - 1)) / FAT_SECTOR_SIZE;

    // First FAT LBA address
    fs->fat_begin_lba = fs->lba_begin + reserved_sectors;

    // The address of the first data cluster on this volume
    fs->cluster_begin_lba = fs->fat_begin_lba + (num_of_fats * fs->fat_sectors);

    if (GET_16BIT_WORD(fs->currentsector.sector, 0x1FE) != 0xAA55) // This signature should be AA55
        return FAT_INIT_INVALID_SIGNATURE;

    // Calculate the root dir sectors
    root_dir_sectors = ((GET_16BIT_WORD(fs->currentsector.sector, BPB_ROOTENTCNT) * 32) + (GET_16BIT_WORD(fs->currentsector.sector, BPB_BYTSPERSEC) - 1)) / GET_16BIT_WORD(fs->currentsector.sector, BPB_BYTSPERSEC);

    if(GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16) != 0)
        FATSz = GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16);
    else
        FATSz = GET_32BIT_WORD(fs->currentsector.sector, BPB_FAT32_FATSZ32);

    if(GET_16BIT_WORD(fs->currentsector.sector, BPB_TOTSEC16) != 0)
        total_sectors = GET_16BIT_WORD(fs->currentsector.sector, BPB_TOTSEC16);
    else
        total_sectors = GET_32BIT_WORD(fs->currentsector.sector, BPB_TOTSEC32);

    data_sectors = total_sectors - (GET_16BIT_WORD(fs->currentsector.sector, BPB_RSVDSECCNT) + (fs->currentsector.sector[BPB_NUMFATS] * FATSz) + root_dir_sectors);

    // Find out which version of FAT this is...
    if (fs->sectors_per_cluster != 0)
    {
        count_of_clusters = data_sectors / fs->sectors_per_cluster;

        if(count_of_clusters < 4085)
            // Volume is FAT12
            return FAT_INIT_WRONG_FILESYS_TYPE;
        else if(count_of_clusters < 65525)
        {
            // Clear this FAT32 specific param
            fs->rootdir_first_cluster = 0;

            // Volume is FAT16
            fs->fat_type = FAT_TYPE_16;
            return FAT_INIT_OK;
        }
        else
        {
            // Volume is FAT32
            fs->fat_type = FAT_TYPE_32;
            return FAT_INIT_OK;
        }
    }
    else
        return FAT_INIT_WRONG_FILESYS_TYPE;
}
//-----------------------------------------------------------------------------
// fatfs_lba_of_cluster: This function converts a cluster number into a sector /
// LBA number.
//-----------------------------------------------------------------------------
uint32 fatfs_lba_of_cluster(struct fatfs *fs, uint32 Cluster_Number)
{
    if (fs->fat_type == FAT_TYPE_16)
        return (fs->cluster_begin_lba + (fs->root_entry_count * 32 / FAT_SECTOR_SIZE) + ((Cluster_Number-2) * fs->sectors_per_cluster));
    else
        return ((fs->cluster_begin_lba + ((Cluster_Number-2)*fs->sectors_per_cluster)));
}
//-----------------------------------------------------------------------------
// fatfs_sector_read:
//-----------------------------------------------------------------------------
int fatfs_sector_read(struct fatfs *fs, uint32 lba, uint8 *target, uint32 count)
{
    return fs->disk_io.read_media(lba, target, count);
}
//-----------------------------------------------------------------------------
// fatfs_sector_write:
//-----------------------------------------------------------------------------
int fatfs_sector_write(struct fatfs *fs, uint32 lba, uint8 *target, uint32 count)
{
    return fs->disk_io.write_media(lba, target, count);
}
//-----------------------------------------------------------------------------
// fatfs_sector_reader: From the provided startcluster and sector offset
// Returns True if success, returns False if not (including if read out of range)
//-----------------------------------------------------------------------------
int fatfs_sector_reader(struct fatfs *fs, uint32 start_cluster, uint32 offset, uint8 *target)
{
    uint32 sector_to_read = 0;
    uint32 cluster_to_read = 0;
    uint32 cluster_chain = 0;
    uint32 i;
    uint32 lba;

    // FAT16 Root directory
    if (fs->fat_type == FAT_TYPE_16 && start_cluster == 0)
    {
        if (offset < fs->rootdir_sectors)
            lba = fs->lba_begin + fs->rootdir_first_sector + offset;
        else
            return 0;
    }
    // FAT16/32 Other
    else
    {
        // Set start of cluster chain to initial value
        cluster_chain = start_cluster;

        // Find parameters
        cluster_to_read = offset / fs->sectors_per_cluster;
        sector_to_read = offset - (cluster_to_read*fs->sectors_per_cluster);

        // Follow chain to find cluster to read
        for (i=0; i<cluster_to_read; i++)
            cluster_chain = fatfs_find_next_cluster(fs, cluster_chain);

        // If end of cluster chain then return false
        if (cluster_chain == FAT32_LAST_CLUSTER)
            return 0;

        // Calculate sector address
        lba = fatfs_lba_of_cluster(fs, cluster_chain)+sector_to_read;
    }

    // User provided target array
    if (target)
        return fs->disk_io.read_media(lba, target, 1);
    // Else read sector if not already loaded
    else if (lba != fs->currentsector.address)
    {
        fs->currentsector.address = lba;
        return fs->disk_io.read_media(fs->currentsector.address, fs->currentsector.sector, 1);
    }
    else
        return 1;
}
//-----------------------------------------------------------------------------
// fatfs_read_sector: Read from the provided cluster and sector offset
// Returns True if success, returns False if not
//-----------------------------------------------------------------------------
int fatfs_read_sector(struct fatfs *fs, uint32 cluster, uint32 sector, uint8 *target)
{
    // FAT16 Root directory
    if (fs->fat_type == FAT_TYPE_16 && cluster == 0)
    {
        uint32 lba;

        // In FAT16, there are a limited amount of sectors in root dir!
        if (sector < fs->rootdir_sectors)
            lba = fs->lba_begin + fs->rootdir_first_sector + sector;
        else
            return 0;

        // User target buffer passed in
        if (target)
        {
            // Read from disk
            return fs->disk_io.read_media(lba, target, 1);
        }
        else
        {
            // Calculate read address
            fs->currentsector.address = lba;

            // Read from disk
            return fs->disk_io.read_media(fs->currentsector.address, fs->currentsector.sector, 1);
        }
    }
    // FAT16/32 Other
    else
    {
        // User target buffer passed in
        if (target)
        {
            // Calculate read address
            uint32 lba = fatfs_lba_of_cluster(fs, cluster) + sector;

            // Read from disk
            return fs->disk_io.read_media(lba, target, 1);
        }
        else
        {
            // Calculate write address
            fs->currentsector.address = fatfs_lba_of_cluster(fs, cluster)+sector;

            // Read from disk
            return fs->disk_io.read_media(fs->currentsector.address, fs->currentsector.sector, 1);
        }
    }
}
//-----------------------------------------------------------------------------
// fatfs_write_sector: Write to the provided cluster and sector offset
// Returns True if success, returns False if not
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_write_sector(struct fatfs *fs, uint32 cluster, uint32 sector, uint8 *target)
{
    // No write access?
    if (!fs->disk_io.write_media)
        return 0;

    // FAT16 Root directory
    if (fs->fat_type == FAT_TYPE_16 && cluster == 0)
    {
        uint32 lba;

        // In FAT16 we cannot extend the root dir!
        if (sector < fs->rootdir_sectors)
            lba = fs->lba_begin + fs->rootdir_first_sector + sector;
        else
            return 0;

        // User target buffer passed in
        if (target)
        {
            // Write to disk
            return fs->disk_io.write_media(lba, target, 1);
        }
        else
        {
            // Calculate write address
            fs->currentsector.address = lba;

            // Write to disk
            return fs->disk_io.write_media(fs->currentsector.address, fs->currentsector.sector, 1);
        }
    }
    // FAT16/32 Other
    else
    {
        // User target buffer passed in
        if (target)
        {
            // Calculate write address
            uint32 lba = fatfs_lba_of_cluster(fs, cluster) + sector;

            // Write to disk
            return fs->disk_io.write_media(lba, target, 1);
        }
        else
        {
            // Calculate write address
            fs->currentsector.address = fatfs_lba_of_cluster(fs, cluster)+sector;

            // Write to disk
            return fs->disk_io.write_media(fs->currentsector.address, fs->currentsector.sector, 1);
        }
    }
}
#endif
//-----------------------------------------------------------------------------
// fatfs_show_details: Show the details about the filesystem
//-----------------------------------------------------------------------------
void fatfs_show_details(struct fatfs *fs)
{
    FAT_PRINTF(("FAT details:\r\n"));
    FAT_PRINTF((" Type =%s", (fs->fat_type == FAT_TYPE_32) ? "FAT32": "FAT16"));
    FAT_PRINTF((" Root Dir First Cluster = %x\r\n", fs->rootdir_first_cluster));
    FAT_PRINTF((" FAT Begin LBA = 0x%x\r\n",fs->fat_begin_lba));
    FAT_PRINTF((" Cluster Begin LBA = 0x%x\r\n",fs->cluster_begin_lba));
    FAT_PRINTF((" Sectors Per Cluster = %d\r\n", fs->sectors_per_cluster));
}
//-----------------------------------------------------------------------------
// fatfs_get_root_cluster: Get the root dir cluster
//-----------------------------------------------------------------------------
uint32 fatfs_get_root_cluster(struct fatfs *fs)
{
    // NOTE: On FAT16 this will be 0 which has a special meaning...
    return fs->rootdir_first_cluster;
}
//-------------------------------------------------------------
// fatfs_get_file_entry: Find the file entry for a filename
//-------------------------------------------------------------
uint32 fatfs_get_file_entry(struct fatfs *fs, uint32 Cluster, char *name_to_find, struct fat_dir_entry *sfEntry)
{
    uint8 item=0;
    uint16 recordoffset = 0;
    uint8 i=0;
    int x=0;
    char *long_filename = NULL;
    char short_filename[13];
    struct lfn_cache lfn;
    int dotRequired = 0;
    struct fat_dir_entry *directoryEntry;

    fatfs_lfn_cache_init(&lfn, 1);

    // Main cluster following loop
    while (1)
    {
        // Read sector
        if (fatfs_sector_reader(fs, Cluster, x++, 0)) // If sector read was successfull
        {
            // Analyse Sector
            for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Create the multiplier for sector access
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // Overlay directory entry over buffer
                directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);

#if FATFS_INC_LFN_SUPPORT
                // Long File Name Text Found
                if (fatfs_entry_lfn_text(directoryEntry) )
                    fatfs_lfn_cache_entry(&lfn, fs->currentsector.sector+recordoffset);

                // If Invalid record found delete any long file name information collated
                else if (fatfs_entry_lfn_invalid(directoryEntry) )
                    fatfs_lfn_cache_init(&lfn, 0);

                // Normal SFN Entry and Long text exists
                else if (fatfs_entry_lfn_exists(&lfn, directoryEntry) )
                {
                    long_filename = fatfs_lfn_cache_get(&lfn);

                    // Compare names to see if they match
                    if (fatfs_compare_names(long_filename, name_to_find))
                    {
                        memcpy(sfEntry,directoryEntry,sizeof(struct fat_dir_entry));
                        return 1;
                    }

                    fatfs_lfn_cache_init(&lfn, 0);
                }
                else
#endif
                // Normal Entry, only 8.3 Text
                if (fatfs_entry_sfn_only(directoryEntry) )
                {
                    memset(short_filename, 0, sizeof(short_filename));

                    // Copy name to string
                    for (i=0; i<8; i++)
                        short_filename[i] = directoryEntry->Name[i];

                    // Extension
                    dotRequired = 0;
                    for (i=8; i<11; i++)
                    {
                        short_filename[i+1] = directoryEntry->Name[i];
                        if (directoryEntry->Name[i] != ' ')
                            dotRequired = 1;
                    }

                    // Dot only required if extension present
                    if (dotRequired)
                    {
                        // If not . or .. entry
                        if (short_filename[0]!='.')
                            short_filename[8] = '.';
                        else
                            short_filename[8] = ' ';
                    }
                    else
                        short_filename[8] = ' ';

                    // Compare names to see if they match
                    if (fatfs_compare_names(short_filename, name_to_find))
                    {
                        memcpy(sfEntry,directoryEntry,sizeof(struct fat_dir_entry));
                        return 1;
                    }

                    fatfs_lfn_cache_init(&lfn, 0);
                }
            } // End of if
        }
        else
            break;
    } // End of while loop

    return 0;
}
//-------------------------------------------------------------
// fatfs_sfn_exists: Check if a short filename exists.
// NOTE: shortname is XXXXXXXXYYY not XXXXXXXX.YYY
//-------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_sfn_exists(struct fatfs *fs, uint32 Cluster, char *shortname)
{
    uint8 item=0;
    uint16 recordoffset = 0;
    int x=0;
    struct fat_dir_entry *directoryEntry;

    // Main cluster following loop
    while (1)
    {
        // Read sector
        if (fatfs_sector_reader(fs, Cluster, x++, 0)) // If sector read was successfull
        {
            // Analyse Sector
            for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Create the multiplier for sector access
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // Overlay directory entry over buffer
                directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);

#if FATFS_INC_LFN_SUPPORT
                // Long File Name Text Found
                if (fatfs_entry_lfn_text(directoryEntry) )
                    ;

                // If Invalid record found delete any long file name information collated
                else if (fatfs_entry_lfn_invalid(directoryEntry) )
                    ;
                else
#endif
                // Normal Entry, only 8.3 Text
                if (fatfs_entry_sfn_only(directoryEntry) )
                {
                    if (strncmp((const char*)directoryEntry->Name, shortname, 11)==0)
                        return 1;
                }
            } // End of if
        }
        else
            break;
    } // End of while loop

    return 0;
}
#endif
//-------------------------------------------------------------
// fatfs_update_timestamps: Update date/time details
//-------------------------------------------------------------
#if FATFS_INC_TIME_DATE_SUPPORT
int fatfs_update_timestamps(struct fat_dir_entry *directoryEntry, int create, int modify, int access)
{
    time_t time_now;
    struct tm * time_info;
    uint16 fat_time;
    uint16 fat_date;

    // Get system time
    time(&time_now);

    // Convert to local time
    time_info = localtime(&time_now);

    // Convert time to FAT format
    fat_time = fatfs_convert_to_fat_time(time_info->tm_hour, time_info->tm_min, time_info->tm_sec);

    // Convert date to FAT format
    fat_date = fatfs_convert_to_fat_date(time_info->tm_mday, time_info->tm_mon + 1, time_info->tm_year + 1900);

    // Update requested fields
    if (create)
    {
        directoryEntry->CrtTime[1] = fat_time >> 8;
        directoryEntry->CrtTime[0] = fat_time >> 0;
        directoryEntry->CrtDate[1] = fat_date >> 8;
        directoryEntry->CrtDate[0] = fat_date >> 0;
    }

    if (modify)
    {
        directoryEntry->WrtTime[1] = fat_time >> 8;
        directoryEntry->WrtTime[0] = fat_time >> 0;
        directoryEntry->WrtDate[1] = fat_date >> 8;
        directoryEntry->WrtDate[0] = fat_date >> 0;
    }

    if (access)
    {
        directoryEntry->LstAccDate[1] = fat_time >> 8;
        directoryEntry->LstAccDate[0] = fat_time >> 0;
        directoryEntry->LstAccDate[1] = fat_date >> 8;
        directoryEntry->LstAccDate[0] = fat_date >> 0;
    }

    return 1;
}
#endif
//-------------------------------------------------------------
// fatfs_update_file_length: Find a SFN entry and update it
// NOTE: shortname is XXXXXXXXYYY not XXXXXXXX.YYY
//-------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_update_file_length(struct fatfs *fs, uint32 Cluster, char *shortname, uint32 fileLength)
{
    uint8 item=0;
    uint16 recordoffset = 0;
    int x=0;
    struct fat_dir_entry *directoryEntry;

    // No write access?
    if (!fs->disk_io.write_media)
        return 0;

    // Main cluster following loop
    while (1)
    {
        // Read sector
        if (fatfs_sector_reader(fs, Cluster, x++, 0)) // If sector read was successfull
        {
            // Analyse Sector
            for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Create the multiplier for sector access
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // Overlay directory entry over buffer
                directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);

#if FATFS_INC_LFN_SUPPORT
                // Long File Name Text Found
                if (fatfs_entry_lfn_text(directoryEntry) )
                    ;

                // If Invalid record found delete any long file name information collated
                else if (fatfs_entry_lfn_invalid(directoryEntry) )
                    ;

                // Normal Entry, only 8.3 Text
                else
#endif
                if (fatfs_entry_sfn_only(directoryEntry) )
                {
                    if (strncmp((const char*)directoryEntry->Name, shortname, 11)==0)
                    {
                        directoryEntry->FileSize = FAT_HTONL(fileLength);

#if FATFS_INC_TIME_DATE_SUPPORT
                        // Update access / modify time & date
                        fatfs_update_timestamps(directoryEntry, 0, 1, 1);
#endif

                        // Update sfn entry
                        memcpy((uint8*)(fs->currentsector.sector+recordoffset), (uint8*)directoryEntry, sizeof(struct fat_dir_entry));

                        // Write sector back
                        return fs->disk_io.write_media(fs->currentsector.address, fs->currentsector.sector, 1);
                    }
                }
            } // End of if
        }
        else
            break;
    } // End of while loop

    return 0;
}
#endif
//-------------------------------------------------------------
// fatfs_mark_file_deleted: Find a SFN entry and mark if as deleted
// NOTE: shortname is XXXXXXXXYYY not XXXXXXXX.YYY
//-------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_mark_file_deleted(struct fatfs *fs, uint32 Cluster, char *shortname)
{
    uint8 item=0;
    uint16 recordoffset = 0;
    int x=0;
    struct fat_dir_entry *directoryEntry;

    // No write access?
    if (!fs->disk_io.write_media)
        return 0;

    // Main cluster following loop
    while (1)
    {
        // Read sector
        if (fatfs_sector_reader(fs, Cluster, x++, 0)) // If sector read was successfull
        {
            // Analyse Sector
            for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Create the multiplier for sector access
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // Overlay directory entry over buffer
                directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);

#if FATFS_INC_LFN_SUPPORT
                // Long File Name Text Found
                if (fatfs_entry_lfn_text(directoryEntry) )
                    ;

                // If Invalid record found delete any long file name information collated
                else if (fatfs_entry_lfn_invalid(directoryEntry) )
                    ;

                // Normal Entry, only 8.3 Text
                else
#endif
                if (fatfs_entry_sfn_only(directoryEntry) )
                {
                    if (strncmp((const char *)directoryEntry->Name, shortname, 11)==0)
                    {
                        // Mark as deleted
                        directoryEntry->Name[0] = FILE_HEADER_DELETED;

#if FATFS_INC_TIME_DATE_SUPPORT
                        // Update access / modify time & date
                        fatfs_update_timestamps(directoryEntry, 0, 1, 1);
#endif

                        // Update sfn entry
                        memcpy((uint8*)(fs->currentsector.sector+recordoffset), (uint8*)directoryEntry, sizeof(struct fat_dir_entry));

                        // Write sector back
                        return fs->disk_io.write_media(fs->currentsector.address, fs->currentsector.sector, 1);
                    }
                }
            } // End of if
        }
        else
            break;
    } // End of while loop

    return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_list_directory_start: Initialise a directory listing procedure
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
void fatfs_list_directory_start(struct fatfs *fs, struct fs_dir_list_status *dirls, uint32 StartCluster)
{
    dirls->cluster = StartCluster;
    dirls->sector = 0;
    dirls->offset = 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_list_directory_next: Get the next entry in the directory.
// Returns: 1 = found, 0 = end of listing
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
int fatfs_list_directory_next(struct fatfs *fs, struct fs_dir_list_status *dirls, struct fs_dir_ent *entry)
{
    uint8 i,item;
    uint16 recordoffset;
    struct fat_dir_entry *directoryEntry;
    char *long_filename = NULL;
    char short_filename[13];
    struct lfn_cache lfn;
    int dotRequired = 0;
    int result = 0;

    // Initialise LFN cache first
    fatfs_lfn_cache_init(&lfn, 0);

    while (1)
    {
        // If data read OK
        if (fatfs_sector_reader(fs, dirls->cluster, dirls->sector, 0))
        {
            // Maximum of 16 directory entries
            for (item = dirls->offset; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Increase directory offset
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // Overlay directory entry over buffer
                directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);

#if FATFS_INC_LFN_SUPPORT
                // Long File Name Text Found
                if ( fatfs_entry_lfn_text(directoryEntry) )
                    fatfs_lfn_cache_entry(&lfn, fs->currentsector.sector+recordoffset);

                // If Invalid record found delete any long file name information collated
                else if ( fatfs_entry_lfn_invalid(directoryEntry) )
                    fatfs_lfn_cache_init(&lfn, 0);

                // Normal SFN Entry and Long text exists
                else if (fatfs_entry_lfn_exists(&lfn, directoryEntry) )
                {
                    // Get text
                    long_filename = fatfs_lfn_cache_get(&lfn);
                    strncpy(entry->filename, long_filename, FATFS_MAX_LONG_FILENAME-1);

                    if (fatfs_entry_is_dir(directoryEntry))
                        entry->is_dir = 1;
                    else
                        entry->is_dir = 0;

#if FATFS_INC_TIME_DATE_SUPPORT
                    // Get time / dates
                    entry->create_time = ((uint16)directoryEntry->CrtTime[1] << 8) | directoryEntry->CrtTime[0];
                    entry->create_date = ((uint16)directoryEntry->CrtDate[1] << 8) | directoryEntry->CrtDate[0];
                    entry->access_date = ((uint16)directoryEntry->LstAccDate[1] << 8) | directoryEntry->LstAccDate[0];
                    entry->write_time  = ((uint16)directoryEntry->WrtTime[1] << 8) | directoryEntry->WrtTime[0];
                    entry->write_date  = ((uint16)directoryEntry->WrtDate[1] << 8) | directoryEntry->WrtDate[0];
#endif

                    entry->size = FAT_HTONL(directoryEntry->FileSize);
                    entry->cluster = (FAT_HTONS(directoryEntry->FstClusHI)<<16) | FAT_HTONS(directoryEntry->FstClusLO);

                    // Next starting position
                    dirls->offset = item + 1;
                    result = 1;
                    return 1;
                }
                // Normal Entry, only 8.3 Text
                else
#endif
                if ( fatfs_entry_sfn_only(directoryEntry) )
                {
                    fatfs_lfn_cache_init(&lfn, 0);

                    memset(short_filename, 0, sizeof(short_filename));

                    // Copy name to string
                    for (i=0; i<8; i++)
                        short_filename[i] = directoryEntry->Name[i];

                    // Extension
                    dotRequired = 0;
                    for (i=8; i<11; i++)
                    {
                        short_filename[i+1] = directoryEntry->Name[i];
                        if (directoryEntry->Name[i] != ' ')
                            dotRequired = 1;
                    }

                    // Dot only required if extension present
                    if (dotRequired)
                    {
                        // If not . or .. entry
                        if (short_filename[0]!='.')
                            short_filename[8] = '.';
                        else
                            short_filename[8] = ' ';
                    }
                    else
                        short_filename[8] = ' ';

                    fatfs_get_sfn_display_name(entry->filename, short_filename);

                    if (fatfs_entry_is_dir(directoryEntry))
                        entry->is_dir = 1;
                    else
                        entry->is_dir = 0;

#if FATFS_INC_TIME_DATE_SUPPORT
                    // Get time / dates
                    entry->create_time = ((uint16)directoryEntry->CrtTime[1] << 8) | directoryEntry->CrtTime[0];
                    entry->create_date = ((uint16)directoryEntry->CrtDate[1] << 8) | directoryEntry->CrtDate[0];
                    entry->access_date = ((uint16)directoryEntry->LstAccDate[1] << 8) | directoryEntry->LstAccDate[0];
                    entry->write_time  = ((uint16)directoryEntry->WrtTime[1] << 8) | directoryEntry->WrtTime[0];
                    entry->write_date  = ((uint16)directoryEntry->WrtDate[1] << 8) | directoryEntry->WrtDate[0];
#endif

                    entry->size = FAT_HTONL(directoryEntry->FileSize);
                    entry->cluster = (FAT_HTONS(directoryEntry->FstClusHI)<<16) | FAT_HTONS(directoryEntry->FstClusLO);

                    // Next starting position
                    dirls->offset = item + 1;
                    result = 1;
                    return 1;
                }
            }// end of for

            // If reached end of the dir move onto next sector
            dirls->sector++;
            dirls->offset = 0;
        }
        else
            break;
    }

    return result;
}
#endif
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

// Per file cluster chain caching used to improve performance.
// This does not have to be enabled for architectures with low
// memory space.

//-----------------------------------------------------------------------------
// fatfs_cache_init:
//-----------------------------------------------------------------------------
int fatfs_cache_init(struct fatfs *fs, FL_FILE *file)
{
#ifdef FAT_CLUSTER_CACHE_ENTRIES
    int i;

    for (i=0;i<FAT_CLUSTER_CACHE_ENTRIES;i++)
    {
        file->cluster_cache_idx[i] = 0xFFFFFFFF; // Not used
        file->cluster_cache_data[i] = 0;
    }
#endif

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_cache_get_next_cluster:
//-----------------------------------------------------------------------------
int fatfs_cache_get_next_cluster(struct fatfs *fs, FL_FILE *file, uint32 clusterIdx, uint32 *pNextCluster)
{
#ifdef FAT_CLUSTER_CACHE_ENTRIES
    uint32 slot = clusterIdx % FAT_CLUSTER_CACHE_ENTRIES;

    if (file->cluster_cache_idx[slot] == clusterIdx)
    {
        *pNextCluster = file->cluster_cache_data[slot];
        return 1;
    }
#endif

    return 0;
}
//-----------------------------------------------------------------------------
// fatfs_cache_set_next_cluster:
//-----------------------------------------------------------------------------
int fatfs_cache_set_next_cluster(struct fatfs *fs, FL_FILE *file, uint32 clusterIdx, uint32 nextCluster)
{
#ifdef FAT_CLUSTER_CACHE_ENTRIES
    uint32 slot = clusterIdx % FAT_CLUSTER_CACHE_ENTRIES;

    if (file->cluster_cache_idx[slot] == clusterIdx)
        file->cluster_cache_data[slot] = nextCluster;
    else
    {
        file->cluster_cache_idx[slot] = clusterIdx;
        file->cluster_cache_data[slot] = nextCluster;
    }
#endif

    return 1;
}
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Locals
//-----------------------------------------------------------------------------
static FL_FILE            _files[FATFS_MAX_OPEN_FILES];
static int                _filelib_init = 0;
static int                _filelib_valid = 0;
static struct fatfs       _fs;
static struct fat_list    _open_file_list;
static struct fat_list    _free_file_list;

//-----------------------------------------------------------------------------
// Macros
//-----------------------------------------------------------------------------

// Macro for checking if file lib is initialised
#define CHECK_FL_INIT()     { if (_filelib_init==0) fl_init(); }

#define FL_LOCK(a)          do { if ((a)->fl_lock) (a)->fl_lock(); } while (0)
#define FL_UNLOCK(a)        do { if ((a)->fl_unlock) (a)->fl_unlock(); } while (0)

//-----------------------------------------------------------------------------
// Local Functions
//-----------------------------------------------------------------------------
static void                _fl_init();

//-----------------------------------------------------------------------------
// _allocate_file: Find a slot in the open files buffer for a new file
//-----------------------------------------------------------------------------
static FL_FILE* _allocate_file(void)
{
    // Allocate free file
    struct fat_node *node = fat_list_pop_head(&_free_file_list);

    // Add to open list
    if (node)
        fat_list_insert_last(&_open_file_list, node);

    return fat_list_entry(node, FL_FILE, list_node);
}
//-----------------------------------------------------------------------------
// _check_file_open: Returns true if the file is already open
//-----------------------------------------------------------------------------
static int _check_file_open(FL_FILE* file)
{
    struct fat_node *node;

    // Compare open files
    fat_list_for_each(&_open_file_list, node)
    {
        FL_FILE* openFile = fat_list_entry(node, FL_FILE, list_node);

        // If not the current file
        if (openFile != file)
        {
            // Compare path and name
            if ( (fatfs_compare_names(openFile->path,file->path)) && (fatfs_compare_names(openFile->filename,file->filename)) )
                return 1;
        }
    }

    return 0;
}
//-----------------------------------------------------------------------------
// _free_file: Free open file handle
//-----------------------------------------------------------------------------
static void _free_file(FL_FILE* file)
{
    // Remove from open list
    fat_list_remove(&_open_file_list, &file->list_node);

    // Add to free list
    fat_list_insert_last(&_free_file_list, &file->list_node);
}

//-----------------------------------------------------------------------------
//                                Low Level
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// _open_directory: Cycle through path string to find the start cluster
// address of the highest subdir.
//-----------------------------------------------------------------------------
static int _open_directory(char *path, uint32 *pathCluster)
{
    int levels;
    int sublevel;
    char currentfolder[FATFS_MAX_LONG_FILENAME];
    struct fat_dir_entry sfEntry;
    uint32 startcluster;

    // Set starting cluster to root cluster
    startcluster = fatfs_get_root_cluster(&_fs);

    // Find number of levels
    levels = fatfs_total_path_levels(path);

    // Cycle through each level and get the start sector
    for (sublevel=0;sublevel<(levels+1);sublevel++)
    {
        if (fatfs_get_substring(path, sublevel, currentfolder, sizeof(currentfolder)) == -1)
            return 0;

        // Find clusteraddress for folder (currentfolder)
        if (fatfs_get_file_entry(&_fs, startcluster, currentfolder,&sfEntry))
        {
            // Check entry is folder
            if (fatfs_entry_is_dir(&sfEntry))
                startcluster = ((FAT_HTONS((uint32)sfEntry.FstClusHI))<<16) + FAT_HTONS(sfEntry.FstClusLO);
            else
                return 0;
        }
        else
            return 0;
    }

    *pathCluster = startcluster;
    return 1;
}
//-----------------------------------------------------------------------------
// _create_directory: Cycle through path string and create the end directory
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
static int _create_directory(char *path)
{
    FL_FILE* file;
    struct fat_dir_entry sfEntry;
    char shortFilename[FAT_SFN_SIZE_FULL];
    int tailNum = 0;
    int i;

    // Allocate a new file handle
    file = _allocate_file();
    if (!file)
        return 0;

    // Clear filename
    memset(file->path, '\0', sizeof(file->path));
    memset(file->filename, '\0', sizeof(file->filename));

    // Split full path into filename and directory path
    if (fatfs_split_path((char*)path, file->path, sizeof(file->path), file->filename, sizeof(file->filename)) == -1)
    {
        _free_file(file);
        return 0;
    }

    // Check if file already open
    if (_check_file_open(file))
    {
        _free_file(file);
        return 0;
    }

    // If file is in the root dir
    if (file->path[0] == 0)
        file->parentcluster = fatfs_get_root_cluster(&_fs);
    else
    {
        // Find parent directory start cluster
        if (!_open_directory(file->path, &file->parentcluster))
        {
            _free_file(file);
            return 0;
        }
    }

    // Check if same filename exists in directory
    if (fatfs_get_file_entry(&_fs, file->parentcluster, file->filename,&sfEntry) == 1)
    {
        _free_file(file);
        return 0;
    }

    file->startcluster = 0;

    // Create the file space for the folder (at least one clusters worth!)
    if (!fatfs_allocate_free_space(&_fs, 1, &file->startcluster, 1))
    {
        _free_file(file);
        return 0;
    }

    // Erase new directory cluster
    memset(file->file_data_sector, 0x00, FAT_SECTOR_SIZE);
    for (i=0;i<_fs.sectors_per_cluster;i++)
    {
        if (!fatfs_write_sector(&_fs, file->startcluster, i, file->file_data_sector))
        {
            _free_file(file);
            return 0;
        }
    }

#if FATFS_INC_LFN_SUPPORT

    // Generate a short filename & tail
    tailNum = 0;
    do
    {
        // Create a standard short filename (without tail)
        fatfs_lfn_create_sfn(shortFilename, file->filename);

        // If second hit or more, generate a ~n tail
        if (tailNum != 0)
            fatfs_lfn_generate_tail((char*)file->shortfilename, shortFilename, tailNum);
        // Try with no tail if first entry
        else
            memcpy(file->shortfilename, shortFilename, FAT_SFN_SIZE_FULL);

        // Check if entry exists already or not
        if (fatfs_sfn_exists(&_fs, file->parentcluster, (char*)file->shortfilename) == 0)
            break;

        tailNum++;
    }
    while (tailNum < 9999);

    // We reached the max number of duplicate short file names (unlikely!)
    if (tailNum == 9999)
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return 0;
    }
#else
    // Create a standard short filename (without tail)
    if (!fatfs_lfn_create_sfn(shortFilename, file->filename))
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return 0;
    }

    // Copy to SFN space
    memcpy(file->shortfilename, shortFilename, FAT_SFN_SIZE_FULL);

    // Check if entry exists already
    if (fatfs_sfn_exists(&_fs, file->parentcluster, (char*)file->shortfilename))
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return 0;
    }
#endif

    // Add file to disk
    if (!fatfs_add_file_entry(&_fs, file->parentcluster, (char*)file->filename, (char*)file->shortfilename, file->startcluster, 0, 1))
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return 0;
    }

    // General
    file->filelength = 0;
    file->bytenum = 0;
    file->file_data_address = 0xFFFFFFFF;
    file->file_data_dirty = 0;
    file->filelength_changed = 0;

    // Quick lookup for next link in the chain
    file->last_fat_lookup.ClusterIdx = 0xFFFFFFFF;
    file->last_fat_lookup.CurrentCluster = 0xFFFFFFFF;

    fatfs_fat_purge(&_fs);

    _free_file(file);
    return 1;
}
#endif
//-----------------------------------------------------------------------------
// _open_file: Open a file for reading
//-----------------------------------------------------------------------------
static FL_FILE* _open_file(const char *path)
{
    FL_FILE* file;
    struct fat_dir_entry sfEntry;

    // Allocate a new file handle
    file = _allocate_file();
    if (!file)
        return NULL;

    // Clear filename
    memset(file->path, '\0', sizeof(file->path));
    memset(file->filename, '\0', sizeof(file->filename));

    // Split full path into filename and directory path
    if (fatfs_split_path((char*)path, file->path, sizeof(file->path), file->filename, sizeof(file->filename)) == -1)
    {
        _free_file(file);
        return NULL;
    }

    // Check if file already open
    if (_check_file_open(file))
    {
        _free_file(file);
        return NULL;
    }

    // If file is in the root dir
    if (file->path[0]==0)
        file->parentcluster = fatfs_get_root_cluster(&_fs);
    else
    {
        // Find parent directory start cluster
        if (!_open_directory(file->path, &file->parentcluster))
        {
            _free_file(file);
            return NULL;
        }
    }

    // Using dir cluster address search for filename
    if (fatfs_get_file_entry(&_fs, file->parentcluster, file->filename,&sfEntry))
        // Make sure entry is file not dir!
        if (fatfs_entry_is_file(&sfEntry))
        {
            // Initialise file details
            memcpy(file->shortfilename, sfEntry.Name, FAT_SFN_SIZE_FULL);
            file->filelength = FAT_HTONL(sfEntry.FileSize);
            file->bytenum = 0;
            file->startcluster = ((FAT_HTONS((uint32)sfEntry.FstClusHI))<<16) + FAT_HTONS(sfEntry.FstClusLO);
            file->file_data_address = 0xFFFFFFFF;
            file->file_data_dirty = 0;
            file->filelength_changed = 0;

            // Quick lookup for next link in the chain
            file->last_fat_lookup.ClusterIdx = 0xFFFFFFFF;
            file->last_fat_lookup.CurrentCluster = 0xFFFFFFFF;

            fatfs_cache_init(&_fs, file);

            fatfs_fat_purge(&_fs);

            return file;
        }

    _free_file(file);
    return NULL;
}
//-----------------------------------------------------------------------------
// _create_file: Create a new file
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
static FL_FILE* _create_file(const char *filename)
{
    FL_FILE* file;
    struct fat_dir_entry sfEntry;
    char shortFilename[FAT_SFN_SIZE_FULL];
    int tailNum = 0;

    // No write access?
    if (!_fs.disk_io.write_media)
        return NULL;

    // Allocate a new file handle
    file = _allocate_file();
    if (!file)
        return NULL;

    // Clear filename
    memset(file->path, '\0', sizeof(file->path));
    memset(file->filename, '\0', sizeof(file->filename));

    // Split full path into filename and directory path
    if (fatfs_split_path((char*)filename, file->path, sizeof(file->path), file->filename, sizeof(file->filename)) == -1)
    {
        _free_file(file);
        return NULL;
    }

    // Check if file already open
    if (_check_file_open(file))
    {
        _free_file(file);
        return NULL;
    }

    // If file is in the root dir
    if (file->path[0] == 0)
        file->parentcluster = fatfs_get_root_cluster(&_fs);
    else
    {
        // Find parent directory start cluster
        if (!_open_directory(file->path, &file->parentcluster))
        {
            _free_file(file);
            return NULL;
        }
    }

    // Check if same filename exists in directory
    if (fatfs_get_file_entry(&_fs, file->parentcluster, file->filename,&sfEntry) == 1)
    {
        _free_file(file);
        return NULL;
    }

    file->startcluster = 0;

    // Create the file space for the file (at least one clusters worth!)
    if (!fatfs_allocate_free_space(&_fs, 1, &file->startcluster, 1))
    {
        _free_file(file);
        return NULL;
    }

#if FATFS_INC_LFN_SUPPORT
    // Generate a short filename & tail
    tailNum = 0;
    do
    {
        // Create a standard short filename (without tail)
        fatfs_lfn_create_sfn(shortFilename, file->filename);

        // If second hit or more, generate a ~n tail
        if (tailNum != 0)
            fatfs_lfn_generate_tail((char*)file->shortfilename, shortFilename, tailNum);
        // Try with no tail if first entry
        else
            memcpy(file->shortfilename, shortFilename, FAT_SFN_SIZE_FULL);

        // Check if entry exists already or not
        if (fatfs_sfn_exists(&_fs, file->parentcluster, (char*)file->shortfilename) == 0)
            break;

        tailNum++;
    }
    while (tailNum < 9999);

    // We reached the max number of duplicate short file names (unlikely!)
    if (tailNum == 9999)
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return NULL;
    }
#else
    // Create a standard short filename (without tail)
    if (!fatfs_lfn_create_sfn(shortFilename, file->filename))
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return NULL;
    }

    // Copy to SFN space
    memcpy(file->shortfilename, shortFilename, FAT_SFN_SIZE_FULL);

    // Check if entry exists already
    if (fatfs_sfn_exists(&_fs, file->parentcluster, (char*)file->shortfilename))
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return NULL;
    }
#endif

    // Add file to disk
    if (!fatfs_add_file_entry(&_fs, file->parentcluster, (char*)file->filename, (char*)file->shortfilename, file->startcluster, 0, 0))
    {
        // Delete allocated space
        fatfs_free_cluster_chain(&_fs, file->startcluster);

        _free_file(file);
        return NULL;
    }

    // General
    file->filelength = 0;
    file->bytenum = 0;
    file->file_data_address = 0xFFFFFFFF;
    file->file_data_dirty = 0;
    file->filelength_changed = 0;

    // Quick lookup for next link in the chain
    file->last_fat_lookup.ClusterIdx = 0xFFFFFFFF;
    file->last_fat_lookup.CurrentCluster = 0xFFFFFFFF;

    fatfs_cache_init(&_fs, file);

    fatfs_fat_purge(&_fs);

    return file;
}
#endif
//-----------------------------------------------------------------------------
// _read_sectors: Read sector(s) from disk to file
//-----------------------------------------------------------------------------
static uint32 _read_sectors(FL_FILE* file, uint32 offset, uint8 *buffer, uint32 count)
{
    uint32 Sector = 0;
    uint32 ClusterIdx = 0;
    uint32 Cluster = 0;
    uint32 i;
    uint32 lba;

    // Find cluster index within file & sector with cluster
    ClusterIdx = offset / _fs.sectors_per_cluster;
    Sector = offset - (ClusterIdx * _fs.sectors_per_cluster);

    // Limit number of sectors read to the number remaining in this cluster
    if ((Sector + count) > _fs.sectors_per_cluster)
        count = _fs.sectors_per_cluster - Sector;

    // Quick lookup for next link in the chain
    if (ClusterIdx == file->last_fat_lookup.ClusterIdx)
        Cluster = file->last_fat_lookup.CurrentCluster;
    // Else walk the chain
    else
    {
        // Starting from last recorded cluster?
        if (ClusterIdx && ClusterIdx == file->last_fat_lookup.ClusterIdx + 1)
        {
            i = file->last_fat_lookup.ClusterIdx;
            Cluster = file->last_fat_lookup.CurrentCluster;
        }
        // Start searching from the beginning..
        else
        {
            // Set start of cluster chain to initial value
            i = 0;
            Cluster = file->startcluster;
        }

        // Follow chain to find cluster to read
        for ( ;i<ClusterIdx; i++)
        {
            uint32 nextCluster;

            // Does the entry exist in the cache?
            if (!fatfs_cache_get_next_cluster(&_fs, file, i, &nextCluster))
            {
                // Scan file linked list to find next entry
                nextCluster = fatfs_find_next_cluster(&_fs, Cluster);

                // Push entry into cache
                fatfs_cache_set_next_cluster(&_fs, file, i, nextCluster);
            }

            Cluster = nextCluster;
        }

        // Record current cluster lookup details (if valid)
        if (Cluster != FAT32_LAST_CLUSTER)
        {
            file->last_fat_lookup.CurrentCluster = Cluster;
            file->last_fat_lookup.ClusterIdx = ClusterIdx;
        }
    }

    // If end of cluster chain then return false
    if (Cluster == FAT32_LAST_CLUSTER)
        return 0;

    // Calculate sector address
    lba = fatfs_lba_of_cluster(&_fs, Cluster) + Sector;

    // Read sector of file
    if (fatfs_sector_read(&_fs, lba, buffer, count))
        return count;
    else
        return 0;
}

//-----------------------------------------------------------------------------
//                                External API
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// fl_init: Initialise library
//-----------------------------------------------------------------------------
void fl_init(void)
{
    int i;

    fat_list_init(&_free_file_list);
    fat_list_init(&_open_file_list);

    // Add all file objects to free list
    for (i=0;i<FATFS_MAX_OPEN_FILES;i++)
        fat_list_insert_last(&_free_file_list, &_files[i].list_node);

    _filelib_init = 1;
}
//-----------------------------------------------------------------------------
// fl_attach_locks:
//-----------------------------------------------------------------------------
void fl_attach_locks(void (*lock)(void), void (*unlock)(void))
{
    _fs.fl_lock = lock;
    _fs.fl_unlock = unlock;
}
//-----------------------------------------------------------------------------
// fl_attach_media:
//-----------------------------------------------------------------------------
int fl_attach_media(fn_diskio_read rd, fn_diskio_write wr)
{
    int res;

    // If first call to library, initialise
    CHECK_FL_INIT();

    _fs.disk_io.read_media = rd;
    _fs.disk_io.write_media = wr;

    // Initialise FAT parameters
    if ((res = fatfs_init(&_fs)) != FAT_INIT_OK)
    {
        FAT_PRINTF(("FAT_FS: Error could not load FAT details (%d)!\r\n", res));
        return res;
    }

    _filelib_valid = 1;
    return FAT_INIT_OK;
}
//-----------------------------------------------------------------------------
// fl_shutdown: Call before shutting down system
//-----------------------------------------------------------------------------
void fl_shutdown(void)
{
    // If first call to library, initialise
    CHECK_FL_INIT();

    FL_LOCK(&_fs);
    fatfs_fat_purge(&_fs);
    FL_UNLOCK(&_fs);
}
//-----------------------------------------------------------------------------
// fopen: Open or Create a file for reading or writing
//-----------------------------------------------------------------------------
void* fl_fopen(const char *path, const char *mode)
{
    int i;
    FL_FILE* file;
    uint8 flags = 0;

    // If first call to library, initialise
    CHECK_FL_INIT();

    if (!_filelib_valid)
        return NULL;

    if (!path || !mode)
        return NULL;

    // Supported Modes:
    // "r" Open a file for reading.
    //        The file must exist.
    // "w" Create an empty file for writing.
    //        If a file with the same name already exists its content is erased and the file is treated as a new empty file.
    // "a" Append to a file.
    //        Writing operations append data at the end of the file.
    //        The file is created if it does not exist.
    // "r+" Open a file for update both reading and writing.
    //        The file must exist.
    // "w+" Create an empty file for both reading and writing.
    //        If a file with the same name already exists its content is erased and the file is treated as a new empty file.
    // "a+" Open a file for reading and appending.
    //        All writing operations are performed at the end of the file, protecting the previous content to be overwritten.
    //        You can reposition (fseek, rewind) the internal pointer to anywhere in the file for reading, but writing operations
    //        will move it back to the end of file.
    //        The file is created if it does not exist.

    for (i=0;i<(int)strlen(mode);i++)
    {
        switch (mode[i])
        {
        case 'r':
        case 'R':
            flags |= FILE_READ;
            break;
        case 'w':
        case 'W':
            flags |= FILE_WRITE;
            flags |= FILE_ERASE;
            flags |= FILE_CREATE;
            break;
        case 'a':
        case 'A':
            flags |= FILE_WRITE;
            flags |= FILE_APPEND;
            flags |= FILE_CREATE;
            break;
        case '+':
            if (flags & FILE_READ)
                flags |= FILE_WRITE;
            else if (flags & FILE_WRITE)
            {
                flags |= FILE_READ;
                flags |= FILE_ERASE;
                flags |= FILE_CREATE;
            }
            else if (flags & FILE_APPEND)
            {
                flags |= FILE_READ;
                flags |= FILE_WRITE;
                flags |= FILE_APPEND;
                flags |= FILE_CREATE;
            }
            break;
        case 'b':
        case 'B':
            flags |= FILE_BINARY;
            break;
        }
    }

    file = NULL;

#if FATFS_INC_WRITE_SUPPORT == 0
    // No write support!
    flags &= ~(FILE_CREATE | FILE_WRITE | FILE_APPEND);
#endif

    // No write access - remove write/modify flags
    if (!_fs.disk_io.write_media)
        flags &= ~(FILE_CREATE | FILE_WRITE | FILE_APPEND);

    FL_LOCK(&_fs);

    // Read
    if (flags & FILE_READ)
        file = _open_file(path);

    // Create New
#if FATFS_INC_WRITE_SUPPORT
    if (!file && (flags & FILE_CREATE))
        file = _create_file(path);
#endif

    // Write Existing (and not open due to read or create)
    if (!(flags & FILE_READ))
        if ((flags & FILE_CREATE) && !file)
            if (flags & (FILE_WRITE | FILE_APPEND))
                file = _open_file(path);

    if (file)
        file->flags = flags;

    FL_UNLOCK(&_fs);
    return file;
}
//-----------------------------------------------------------------------------
// _write_sectors: Write sector(s) to disk
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
static uint32 _write_sectors(FL_FILE* file, uint32 offset, uint8 *buf, uint32 count)
{
    uint32 SectorNumber = 0;
    uint32 ClusterIdx = 0;
    uint32 Cluster = 0;
    uint32 LastCluster = FAT32_LAST_CLUSTER;
    uint32 i;
    uint32 lba;
    uint32 TotalWriteCount = count;

    // Find values for Cluster index & sector within cluster
    ClusterIdx = offset / _fs.sectors_per_cluster;
    SectorNumber = offset - (ClusterIdx * _fs.sectors_per_cluster);

    // Limit number of sectors written to the number remaining in this cluster
    if ((SectorNumber + count) > _fs.sectors_per_cluster)
        count = _fs.sectors_per_cluster - SectorNumber;

    // Quick lookup for next link in the chain
    if (ClusterIdx == file->last_fat_lookup.ClusterIdx)
        Cluster = file->last_fat_lookup.CurrentCluster;
    // Else walk the chain
    else
    {
        // Starting from last recorded cluster?
        if (ClusterIdx && ClusterIdx == file->last_fat_lookup.ClusterIdx + 1)
        {
            i = file->last_fat_lookup.ClusterIdx;
            Cluster = file->last_fat_lookup.CurrentCluster;
        }
        // Start searching from the beginning..
        else
        {
            // Set start of cluster chain to initial value
            i = 0;
            Cluster = file->startcluster;
        }

        // Follow chain to find cluster to read
        for ( ;i<ClusterIdx; i++)
        {
            uint32 nextCluster;

            // Does the entry exist in the cache?
            if (!fatfs_cache_get_next_cluster(&_fs, file, i, &nextCluster))
            {
                // Scan file linked list to find next entry
                nextCluster = fatfs_find_next_cluster(&_fs, Cluster);

                // Push entry into cache
                fatfs_cache_set_next_cluster(&_fs, file, i, nextCluster);
            }

            LastCluster = Cluster;
            Cluster = nextCluster;

            // Dont keep following a dead end
            if (Cluster == FAT32_LAST_CLUSTER)
                break;
        }

        // If we have reached the end of the chain, allocate more!
        if (Cluster == FAT32_LAST_CLUSTER)
        {
            // Add some more cluster(s) to the last good cluster chain
            if (!fatfs_add_free_space(&_fs, &LastCluster,  (TotalWriteCount + _fs.sectors_per_cluster -1) / _fs.sectors_per_cluster))
                return 0;

            Cluster = LastCluster;
        }

        // Record current cluster lookup details
        file->last_fat_lookup.CurrentCluster = Cluster;
        file->last_fat_lookup.ClusterIdx = ClusterIdx;
    }

    // Calculate write address
    lba = fatfs_lba_of_cluster(&_fs, Cluster) + SectorNumber;

    if (fatfs_sector_write(&_fs, lba, buf, count))
        return count;
    else
        return 0;
}
#endif
//-----------------------------------------------------------------------------
// fl_fflush: Flush un-written data to the file
//-----------------------------------------------------------------------------
int fl_fflush(void *f)
{
#if FATFS_INC_WRITE_SUPPORT
    FL_FILE *file = (FL_FILE *)f;

    // If first call to library, initialise
    CHECK_FL_INIT();

    if (file)
    {
        FL_LOCK(&_fs);

        // If some write data still in buffer
        if (file->file_data_dirty)
        {
            // Write back current sector before loading next
            if (_write_sectors(file, file->file_data_address, file->file_data_sector, 1))
                file->file_data_dirty = 0;
        }

        FL_UNLOCK(&_fs);
    }
#endif
    return 0;
}
//-----------------------------------------------------------------------------
// fl_fclose: Close an open file
//-----------------------------------------------------------------------------
void fl_fclose(void *f)
{
    FL_FILE *file = (FL_FILE *)f;

    // If first call to library, initialise
    CHECK_FL_INIT();

    if (file)
    {
        FL_LOCK(&_fs);

        // Flush un-written data to file
        fl_fflush(f);

        // File size changed?
        if (file->filelength_changed)
        {
#if FATFS_INC_WRITE_SUPPORT
            // Update filesize in directory
            fatfs_update_file_length(&_fs, file->parentcluster, (char*)file->shortfilename, file->filelength);
#endif
            file->filelength_changed = 0;
        }

        file->bytenum = 0;
        file->filelength = 0;
        file->startcluster = 0;
        file->file_data_address = 0xFFFFFFFF;
        file->file_data_dirty = 0;
        file->filelength_changed = 0;

        // Free file handle
        _free_file(file);

        fatfs_fat_purge(&_fs);

        FL_UNLOCK(&_fs);
    }
}
//-----------------------------------------------------------------------------
// fl_fgetc: Get a character in the stream
//-----------------------------------------------------------------------------
int fl_fgetc(void *f)
{
    int res;
    uint8 data = 0;

    res = fl_fread(&data, 1, 1, f);
    if (res == 1)
        return (int)data;
    else
        return res;
}
//-----------------------------------------------------------------------------
// fl_fgets: Get a string from a stream
//-----------------------------------------------------------------------------
char *fl_fgets(char *s, int n, void *f)
{
    int idx = 0;

    // Space for null terminator?
    if (n > 0)
    {
        // While space (+space for null terminator)
        while (idx < (n-1))
        {
            int ch = fl_fgetc(f);

            // EOF / Error?
            if (ch < 0)
                break;

            // Store character read from stream
            s[idx++] = (char)ch;

            // End of line?
            if (ch == '\n')
                break;
        }

        if (idx > 0)
            s[idx] = '\0';
    }

    return (idx > 0) ? s : 0;
}
//-----------------------------------------------------------------------------
// fl_fread: Read a block of data from the file
//-----------------------------------------------------------------------------
int fl_fread(void * buffer, int size, int length, void *f )
{
    uint32 sector;
    uint32 offset;
    int copyCount;
    int count = size * length;
    int bytesRead = 0;

    FL_FILE *file = (FL_FILE *)f;

    // If first call to library, initialise
    CHECK_FL_INIT();

    if (buffer==NULL || file==NULL)
        return -1;

    // No read permissions
    if (!(file->flags & FILE_READ))
        return -1;

    // Nothing to be done
    if (!count)
        return 0;

    // Check if read starts past end of file
    if (file->bytenum >= file->filelength)
        return -1;

    // Limit to file size
    if ( (file->bytenum + count) > file->filelength )
        count = file->filelength - file->bytenum;

    // Calculate start sector
    sector = file->bytenum / FAT_SECTOR_SIZE;

    // Offset to start copying data from first sector
    offset = file->bytenum % FAT_SECTOR_SIZE;

    while (bytesRead < count)
    {
        // Read whole sector, read from media directly into target buffer
        if ((offset == 0) && ((count - bytesRead) >= FAT_SECTOR_SIZE))
        {
            // Read as many sectors as possible into target buffer
            uint32 sectorsRead = _read_sectors(file, sector, (uint8*)((uint8*)buffer + bytesRead), (count - bytesRead) / FAT_SECTOR_SIZE);
            if (sectorsRead)
            {
                // We have upto one sector to copy
                copyCount = FAT_SECTOR_SIZE * sectorsRead;

                // Move onto next sector and reset copy offset
                sector+= sectorsRead;
                offset = 0;
            }
            else
                break;
        }
        else
        {
            // Do we need to re-read the sector?
            if (file->file_data_address != sector)
            {
                // Flush un-written data to file
                if (file->file_data_dirty)
                    fl_fflush(file);

                // Get LBA of sector offset within file
                if (!_read_sectors(file, sector, file->file_data_sector, 1))
                    // Read failed - out of range (probably)
                    break;

                file->file_data_address = sector;
                file->file_data_dirty = 0;
            }

            // We have upto one sector to copy
            copyCount = FAT_SECTOR_SIZE - offset;

            // Only require some of this sector?
            if (copyCount > (count - bytesRead))
                copyCount = (count - bytesRead);

            // Copy to application buffer
            memcpy( (uint8*)((uint8*)buffer + bytesRead), (uint8*)(file->file_data_sector + offset), copyCount);

            // Move onto next sector and reset copy offset
            sector++;
            offset = 0;
        }

        // Increase total read count
        bytesRead += copyCount;

        // Increment file pointer
        file->bytenum += copyCount;
    }

    return bytesRead;
}
//-----------------------------------------------------------------------------
// fl_fseek: Seek to a specific place in the file
//-----------------------------------------------------------------------------
int fl_fseek( void *f, long offset, int origin )
{
    FL_FILE *file = (FL_FILE *)f;
    int res = -1;

    // If first call to library, initialise
    CHECK_FL_INIT();

    if (!file)
        return -1;

    if (origin == SEEK_END && offset != 0)
        return -1;

    FL_LOCK(&_fs);

    // Invalidate file buffer
    file->file_data_address = 0xFFFFFFFF;
    file->file_data_dirty = 0;

    if (origin == SEEK_SET)
    {
        file->bytenum = (uint32)offset;

        if (file->bytenum > file->filelength)
            file->bytenum = file->filelength;

        res = 0;
    }
    else if (origin == SEEK_CUR)
    {
        // Positive shift
        if (offset >= 0)
        {
            file->bytenum += offset;

            if (file->bytenum > file->filelength)
                file->bytenum = file->filelength;
        }
        // Negative shift
        else
        {
            // Make shift positive
            offset = -offset;

            // Limit to negative shift to start of file
            if ((uint32)offset > file->bytenum)
                file->bytenum = 0;
            else
                file->bytenum-= offset;
        }

        res = 0;
    }
    else if (origin == SEEK_END)
    {
        file->bytenum = file->filelength;
        res = 0;
    }
    else
        res = -1;

    FL_UNLOCK(&_fs);

    return res;
}
//-----------------------------------------------------------------------------
// fl_fgetpos: Get the current file position
//-----------------------------------------------------------------------------
int fl_fgetpos(void *f , uint32 * position)
{
    FL_FILE *file = (FL_FILE *)f;

    if (!file)
        return -1;

    FL_LOCK(&_fs);

    // Get position
    *position = file->bytenum;

    FL_UNLOCK(&_fs);

    return 0;
}
//-----------------------------------------------------------------------------
// fl_ftell: Get the current file position
//-----------------------------------------------------------------------------
long fl_ftell(void *f)
{
    uint32 pos = 0;

    fl_fgetpos(f, &pos);

    return (long)pos;
}
//-----------------------------------------------------------------------------
// fl_feof: Is the file pointer at the end of the stream?
//-----------------------------------------------------------------------------
int fl_feof(void *f)
{
    FL_FILE *file = (FL_FILE *)f;
    int res;

    if (!file)
        return -1;

    FL_LOCK(&_fs);

    if (file->bytenum == file->filelength)
        res = EOF;
    else
        res = 0;

    FL_UNLOCK(&_fs);

    return res;
}
//-----------------------------------------------------------------------------
// fl_fputc: Write a character to the stream
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fl_fputc(int c, void *f)
{
    uint8 data = (uint8)c;
    int res;

    res = fl_fwrite(&data, 1, 1, f);
    if (res == 1)
        return c;
    else
        return res;
}
#endif
//-----------------------------------------------------------------------------
// fl_fwrite: Write a block of data to the stream
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fl_fwrite(const void * data, int size, int count, void *f )
{
    FL_FILE *file = (FL_FILE *)f;
    uint32 sector;
    uint32 offset;
    uint32 length = (size*count);
    uint8 *buffer = (uint8 *)data;
    uint32 bytesWritten = 0;
    uint32 copyCount;

    // If first call to library, initialise
    CHECK_FL_INIT();

    if (!file)
        return -1;

    FL_LOCK(&_fs);

    // No write permissions
    if (!(file->flags & FILE_WRITE))
    {
        FL_UNLOCK(&_fs);
        return -1;
    }

    // Append writes to end of file
    if (file->flags & FILE_APPEND)
        file->bytenum = file->filelength;
    // Else write to current position

    // Calculate start sector
    sector = file->bytenum / FAT_SECTOR_SIZE;

    // Offset to start copying data from first sector
    offset = file->bytenum % FAT_SECTOR_SIZE;

    while (bytesWritten < length)
    {
        // Whole sector or more to be written?
        if ((offset == 0) && ((length - bytesWritten) >= FAT_SECTOR_SIZE))
        {
            uint32 sectorsWrote;

            // Buffered sector, flush back to disk
            if (file->file_data_address != 0xFFFFFFFF)
            {
                // Flush un-written data to file
                if (file->file_data_dirty)
                    fl_fflush(file);

                file->file_data_address = 0xFFFFFFFF;
                file->file_data_dirty = 0;
            }

            // Write as many sectors as possible
            sectorsWrote = _write_sectors(file, sector, (uint8*)(buffer + bytesWritten), (length - bytesWritten) / FAT_SECTOR_SIZE);
            copyCount = FAT_SECTOR_SIZE * sectorsWrote;

            // Increase total read count
            bytesWritten += copyCount;

            // Increment file pointer
            file->bytenum += copyCount;

            // Move onto next sector and reset copy offset
            sector+= sectorsWrote;
            offset = 0;

            if (!sectorsWrote)
                break;
        }
        else
        {
            // We have upto one sector to copy
            copyCount = FAT_SECTOR_SIZE - offset;

            // Only require some of this sector?
            if (copyCount > (length - bytesWritten))
                copyCount = (length - bytesWritten);

            // Do we need to read a new sector?
            if (file->file_data_address != sector)
            {
                // Flush un-written data to file
                if (file->file_data_dirty)
                    fl_fflush(file);

                // If we plan to overwrite the whole sector, we don't need to read it first!
                if (copyCount != FAT_SECTOR_SIZE)
                {
                    // NOTE: This does not have succeed; if last sector of file
                    // reached, no valid data will be read in, but write will
                    // allocate some more space for new data.

                    // Get LBA of sector offset within file
                    if (!_read_sectors(file, sector, file->file_data_sector, 1))
                        memset(file->file_data_sector, 0x00, FAT_SECTOR_SIZE);
                }

                file->file_data_address = sector;
                file->file_data_dirty = 0;
            }

            // Copy from application buffer into sector buffer
            memcpy((uint8*)(file->file_data_sector + offset), (uint8*)(buffer + bytesWritten), copyCount);

            // Mark buffer as dirty
            file->file_data_dirty = 1;

            // Increase total read count
            bytesWritten += copyCount;

            // Increment file pointer
            file->bytenum += copyCount;

            // Move onto next sector and reset copy offset
            sector++;
            offset = 0;
        }
    }

    // Write increased extent of the file?
    if (file->bytenum > file->filelength)
    {
        // Increase file size to new point
        file->filelength = file->bytenum;

        // We are changing the file length and this
        // will need to be writen back at some point
        file->filelength_changed = 1;
    }

#if FATFS_INC_TIME_DATE_SUPPORT
    // If time & date support is enabled, always force directory entry to be
    // written in-order to update file modify / access time & date.
    file->filelength_changed = 1;
#endif

    FL_UNLOCK(&_fs);

    return (size*count);
}
#endif
//-----------------------------------------------------------------------------
// fl_fputs: Write a character string to the stream
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fl_fputs(const char * str, void *f)
{
    int len = (int)strlen(str);
    int res = fl_fwrite(str, 1, len, f);

    if (res == len)
        return len;
    else
        return res;
}
#endif
//-----------------------------------------------------------------------------
// fl_remove: Remove a file from the filesystem
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fl_remove( const char * filename )
{
    FL_FILE* file;
    int res = -1;

    FL_LOCK(&_fs);

    // Use read_file as this will check if the file is already open!
    file = (FL_FILE*)fl_fopen((char*)filename, "r");
    if (file)
    {
        // Delete allocated space
        if (fatfs_free_cluster_chain(&_fs, file->startcluster))
        {
            // Remove directory entries
            if (fatfs_mark_file_deleted(&_fs, file->parentcluster, (char*)file->shortfilename))
            {
                // Close the file handle (this should not write anything to the file
                // as we have not changed the file since opening it!)
                fl_fclose(file);

                res = 0;
            }
        }
    }

    FL_UNLOCK(&_fs);

    return res;
}
#endif
//-----------------------------------------------------------------------------
// fl_createdirectory: Create a directory based on a path
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fl_createdirectory(const char *path)
{
    int res;

    // If first call to library, initialise
    CHECK_FL_INIT();

    FL_LOCK(&_fs);
    res =_create_directory((char*)path);
    FL_UNLOCK(&_fs);

    return res;
}
#endif
//-----------------------------------------------------------------------------
// fl_listdirectory: List a directory based on a path
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
void fl_listdirectory(const char *path)
{
    FL_DIR dirstat;

    // If first call to library, initialise
    CHECK_FL_INIT();

    FL_LOCK(&_fs);

    FAT_PRINTF(("\r\nDirectory %s\r\n", path));

    if (fl_opendir(path, &dirstat))
    {
        struct fs_dir_ent dirent;

        while (fl_readdir(&dirstat, &dirent) == 0)
        {
#if FATFS_INC_TIME_DATE_SUPPORT
            int d,m,y,h,mn,s;
            fatfs_convert_from_fat_time(dirent.write_time, &h,&m,&s);
            fatfs_convert_from_fat_date(dirent.write_date, &d,&mn,&y);
            FAT_PRINTF(("%02d/%02d/%04d  %02d:%02d      ", d,mn,y,h,m));
#endif

            if (dirent.is_dir)
            {
                FAT_PRINTF(("%s <DIR>\r\n", dirent.filename));
            }
            else
            {
                FAT_PRINTF(("%s [%d bytes]\r\n", dirent.filename, dirent.size));
            }
        }

        fl_closedir(&dirstat);
    }

    FL_UNLOCK(&_fs);
}
#endif
//-----------------------------------------------------------------------------
// fl_opendir: Opens a directory for listing
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
FL_DIR* fl_opendir(const char* path, FL_DIR *dir)
{
    int levels;
    int res = 1;
    uint32 cluster = FAT32_INVALID_CLUSTER;

    // If first call to library, initialise
    CHECK_FL_INIT();

    FL_LOCK(&_fs);

    levels = fatfs_total_path_levels((char*)path) + 1;

    // If path is in the root dir
    if (levels == 0)
        cluster = fatfs_get_root_cluster(&_fs);
    // Find parent directory start cluster
    else
        res = _open_directory((char*)path, &cluster);

    if (res)
        fatfs_list_directory_start(&_fs, dir, cluster);

    FL_UNLOCK(&_fs);

    return cluster != FAT32_INVALID_CLUSTER ? dir : 0;
}
#endif
//-----------------------------------------------------------------------------
// fl_readdir: Get next item in directory
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
int fl_readdir(FL_DIR *dirls, fl_dirent *entry)
{
    int res = 0;

    // If first call to library, initialise
    CHECK_FL_INIT();

    FL_LOCK(&_fs);

    res = fatfs_list_directory_next(&_fs, dirls, entry);

    FL_UNLOCK(&_fs);

    return res ? 0 : -1;
}
#endif
//-----------------------------------------------------------------------------
// fl_closedir: Close directory after listing
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
int fl_closedir(FL_DIR* dir)
{
    // Not used
    return 0;
}
#endif
//-----------------------------------------------------------------------------
// fl_is_dir: Is this a directory?
//-----------------------------------------------------------------------------
#if FATFS_DIR_LIST_SUPPORT
int fl_is_dir(const char *path)
{
    int res = 0;
    FL_DIR dir;

    if (fl_opendir(path, &dir))
    {
        res = 1;
        fl_closedir(&dir);
    }

    return res;
}
#endif
//-----------------------------------------------------------------------------
// fl_format: Format a partition with either FAT16 or FAT32 based on size
//-----------------------------------------------------------------------------
#if FATFS_INC_FORMAT_SUPPORT
int fl_format(uint32 volume_sectors, const char *name)
{
    return fatfs_format(&_fs, volume_sectors, name);
}
#endif /*FATFS_INC_FORMAT_SUPPORT*/
//-----------------------------------------------------------------------------
// fl_get_fs:
//-----------------------------------------------------------------------------
#ifdef FATFS_INC_TEST_HOOKS
struct fatfs* fl_get_fs(void)
{
    return &_fs;
}
#endif
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

#if FATFS_INC_FORMAT_SUPPORT

//-----------------------------------------------------------------------------
// Tables
//-----------------------------------------------------------------------------
struct sec_per_clus_table
{
    uint32  sectors;
    uint8   sectors_per_cluster;
};

struct sec_per_clus_table _cluster_size_table16[] =
{
    { 32680, 2},    // 16MB - 1K
    { 262144, 4},   // 128MB - 2K
    { 524288, 8},   // 256MB - 4K
    { 1048576, 16}, // 512MB - 8K
    { 2097152, 32}, // 1GB - 16K
    { 4194304, 64}, // 2GB - 32K
    { 8388608, 128},// 2GB - 64K [Warning only supported by Windows XP onwards]
    { 0 , 0 }       // Invalid
};

struct sec_per_clus_table _cluster_size_table32[] =
{
    { 532480, 1},     // 260MB - 512b
    { 16777216, 8},   // 8GB - 4K
    { 33554432, 16},  // 16GB - 8K
    { 67108864, 32},  // 32GB - 16K
    { 0xFFFFFFFF, 64},// >32GB - 32K
    { 0 , 0 }         // Invalid
};

//-----------------------------------------------------------------------------
// fatfs_calc_cluster_size: Calculate what cluster size should be used
//-----------------------------------------------------------------------------
static uint8 fatfs_calc_cluster_size(uint32 sectors, int is_fat32)
{
    int i;

    if (!is_fat32)
    {
        for (i=0; _cluster_size_table16[i].sectors_per_cluster != 0;i++)
            if (sectors <= _cluster_size_table16[i].sectors)
                return _cluster_size_table16[i].sectors_per_cluster;
    }
    else
    {
        for (i=0; _cluster_size_table32[i].sectors_per_cluster != 0;i++)
            if (sectors <= _cluster_size_table32[i].sectors)
                return _cluster_size_table32[i].sectors_per_cluster;
    }

    return 0;
}
//-----------------------------------------------------------------------------
// fatfs_erase_sectors: Erase a number of sectors
//-----------------------------------------------------------------------------
static int fatfs_erase_sectors(struct fatfs *fs, uint32 lba, int count)
{
    int i;

    // Zero sector first
    memset(fs->currentsector.sector, 0, FAT_SECTOR_SIZE);

    for (i=0;i<count;i++)
        if (!fs->disk_io.write_media(lba + i, fs->currentsector.sector, 1))
            return 0;

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_create_boot_sector: Create the boot sector
//-----------------------------------------------------------------------------
static int fatfs_create_boot_sector(struct fatfs *fs, uint32 boot_sector_lba, uint32 vol_sectors, const char *name, int is_fat32)
{
    uint32 total_clusters;
    int i;

    // Zero sector initially
    memset(fs->currentsector.sector, 0, FAT_SECTOR_SIZE);

    // OEM Name & Jump Code
    fs->currentsector.sector[0] = 0xEB;
    fs->currentsector.sector[1] = 0x3C;
    fs->currentsector.sector[2] = 0x90;
    fs->currentsector.sector[3] = 0x4D;
    fs->currentsector.sector[4] = 0x53;
    fs->currentsector.sector[5] = 0x44;
    fs->currentsector.sector[6] = 0x4F;
    fs->currentsector.sector[7] = 0x53;
    fs->currentsector.sector[8] = 0x35;
    fs->currentsector.sector[9] = 0x2E;
    fs->currentsector.sector[10] = 0x30;

    // Bytes per sector
    fs->currentsector.sector[11] = (FAT_SECTOR_SIZE >> 0) & 0xFF;
    fs->currentsector.sector[12] = (FAT_SECTOR_SIZE >> 8) & 0xFF;

    // Get sectors per cluster size for the disk
    fs->sectors_per_cluster = fatfs_calc_cluster_size(vol_sectors, is_fat32);
    if (!fs->sectors_per_cluster)
        return 0; // Invalid disk size

    // Sectors per cluster
    fs->currentsector.sector[13] = fs->sectors_per_cluster;

    // Reserved Sectors
    if (!is_fat32)
        fs->reserved_sectors = 8;
    else
        fs->reserved_sectors = 32;
    fs->currentsector.sector[14] = (fs->reserved_sectors >> 0) & 0xFF;
    fs->currentsector.sector[15] = (fs->reserved_sectors >> 8) & 0xFF;

    // Number of FATS
    fs->num_of_fats = 2;
    fs->currentsector.sector[16] = fs->num_of_fats;

    // Max entries in root dir (FAT16 only)
    if (!is_fat32)
    {
        fs->root_entry_count = 512;
        fs->currentsector.sector[17] = (fs->root_entry_count >> 0) & 0xFF;
        fs->currentsector.sector[18] = (fs->root_entry_count >> 8) & 0xFF;
    }
    else
    {
        fs->root_entry_count = 0;
        fs->currentsector.sector[17] = 0;
        fs->currentsector.sector[18] = 0;
    }

    // [FAT16] Total sectors (use FAT32 count instead)
    fs->currentsector.sector[19] = 0x00;
    fs->currentsector.sector[20] = 0x00;

    // Media type
    fs->currentsector.sector[21] = 0xF8;


    // FAT16 BS Details
    if (!is_fat32)
    {
        // Count of sectors used by the FAT table (FAT16 only)
        total_clusters = (vol_sectors / fs->sectors_per_cluster) + 1;
        fs->fat_sectors = (total_clusters/(FAT_SECTOR_SIZE/2)) + 1;
        fs->currentsector.sector[22] = (uint8)((fs->fat_sectors >> 0) & 0xFF);
        fs->currentsector.sector[23] = (uint8)((fs->fat_sectors >> 8) & 0xFF);

        // Sectors per track
        fs->currentsector.sector[24] = 0x00;
        fs->currentsector.sector[25] = 0x00;

        // Heads
        fs->currentsector.sector[26] = 0x00;
        fs->currentsector.sector[27] = 0x00;

        // Hidden sectors
        fs->currentsector.sector[28] = 0x20;
        fs->currentsector.sector[29] = 0x00;
        fs->currentsector.sector[30] = 0x00;
        fs->currentsector.sector[31] = 0x00;

        // Total sectors for this volume
        fs->currentsector.sector[32] = (uint8)((vol_sectors>>0)&0xFF);
        fs->currentsector.sector[33] = (uint8)((vol_sectors>>8)&0xFF);
        fs->currentsector.sector[34] = (uint8)((vol_sectors>>16)&0xFF);
        fs->currentsector.sector[35] = (uint8)((vol_sectors>>24)&0xFF);

        // Drive number
        fs->currentsector.sector[36] = 0x00;

        // Reserved
        fs->currentsector.sector[37] = 0x00;

        // Boot signature
        fs->currentsector.sector[38] = 0x29;

        // Volume ID
        fs->currentsector.sector[39] = 0x12;
        fs->currentsector.sector[40] = 0x34;
        fs->currentsector.sector[41] = 0x56;
        fs->currentsector.sector[42] = 0x78;

        // Volume name
        for (i=0;i<11;i++)
        {
            if (i < (int)strlen(name))
                fs->currentsector.sector[i+43] = name[i];
            else
                fs->currentsector.sector[i+43] = ' ';
        }

        // File sys type
        fs->currentsector.sector[54] = 'F';
        fs->currentsector.sector[55] = 'A';
        fs->currentsector.sector[56] = 'T';
        fs->currentsector.sector[57] = '1';
        fs->currentsector.sector[58] = '6';
        fs->currentsector.sector[59] = ' ';
        fs->currentsector.sector[60] = ' ';
        fs->currentsector.sector[61] = ' ';

        // Signature
        fs->currentsector.sector[510] = 0x55;
        fs->currentsector.sector[511] = 0xAA;
    }
    // FAT32 BS Details
    else
    {
        // Count of sectors used by the FAT table (FAT16 only)
        fs->currentsector.sector[22] = 0;
        fs->currentsector.sector[23] = 0;

        // Sectors per track (default)
        fs->currentsector.sector[24] = 0x3F;
        fs->currentsector.sector[25] = 0x00;

        // Heads (default)
        fs->currentsector.sector[26] = 0xFF;
        fs->currentsector.sector[27] = 0x00;

        // Hidden sectors
        fs->currentsector.sector[28] = 0x00;
        fs->currentsector.sector[29] = 0x00;
        fs->currentsector.sector[30] = 0x00;
        fs->currentsector.sector[31] = 0x00;

        // Total sectors for this volume
        fs->currentsector.sector[32] = (uint8)((vol_sectors>>0)&0xFF);
        fs->currentsector.sector[33] = (uint8)((vol_sectors>>8)&0xFF);
        fs->currentsector.sector[34] = (uint8)((vol_sectors>>16)&0xFF);
        fs->currentsector.sector[35] = (uint8)((vol_sectors>>24)&0xFF);

        total_clusters = (vol_sectors / fs->sectors_per_cluster) + 1;
        fs->fat_sectors = (total_clusters/(FAT_SECTOR_SIZE/4)) + 1;

        // BPB_FATSz32
        fs->currentsector.sector[36] = (uint8)((fs->fat_sectors>>0)&0xFF);
        fs->currentsector.sector[37] = (uint8)((fs->fat_sectors>>8)&0xFF);
        fs->currentsector.sector[38] = (uint8)((fs->fat_sectors>>16)&0xFF);
        fs->currentsector.sector[39] = (uint8)((fs->fat_sectors>>24)&0xFF);

        // BPB_ExtFlags
        fs->currentsector.sector[40] = 0;
        fs->currentsector.sector[41] = 0;

        // BPB_FSVer
        fs->currentsector.sector[42] = 0;
        fs->currentsector.sector[43] = 0;

        // BPB_RootClus
        fs->currentsector.sector[44] = (uint8)((fs->rootdir_first_cluster>>0)&0xFF);
        fs->currentsector.sector[45] = (uint8)((fs->rootdir_first_cluster>>8)&0xFF);
        fs->currentsector.sector[46] = (uint8)((fs->rootdir_first_cluster>>16)&0xFF);
        fs->currentsector.sector[47] = (uint8)((fs->rootdir_first_cluster>>24)&0xFF);

        // BPB_FSInfo
        fs->currentsector.sector[48] = (uint8)((fs->fs_info_sector>>0)&0xFF);
        fs->currentsector.sector[49] = (uint8)((fs->fs_info_sector>>8)&0xFF);

        // BPB_BkBootSec
        fs->currentsector.sector[50] = 6;
        fs->currentsector.sector[51] = 0;

        // Drive number
        fs->currentsector.sector[64] = 0x00;

        // Boot signature
        fs->currentsector.sector[66] = 0x29;

        // Volume ID
        fs->currentsector.sector[67] = 0x12;
        fs->currentsector.sector[68] = 0x34;
        fs->currentsector.sector[69] = 0x56;
        fs->currentsector.sector[70] = 0x78;

        // Volume name
        for (i=0;i<11;i++)
        {
            if (i < (int)strlen(name))
                fs->currentsector.sector[i+71] = name[i];
            else
                fs->currentsector.sector[i+71] = ' ';
        }

        // File sys type
        fs->currentsector.sector[82] = 'F';
        fs->currentsector.sector[83] = 'A';
        fs->currentsector.sector[84] = 'T';
        fs->currentsector.sector[85] = '3';
        fs->currentsector.sector[86] = '2';
        fs->currentsector.sector[87] = ' ';
        fs->currentsector.sector[88] = ' ';
        fs->currentsector.sector[89] = ' ';

        // Signature
        fs->currentsector.sector[510] = 0x55;
        fs->currentsector.sector[511] = 0xAA;
    }

    if (fs->disk_io.write_media(boot_sector_lba, fs->currentsector.sector, 1))
        return 1;
    else
        return 0;
}
//-----------------------------------------------------------------------------
// fatfs_create_fsinfo_sector: Create the FSInfo sector (FAT32)
//-----------------------------------------------------------------------------
static int fatfs_create_fsinfo_sector(struct fatfs *fs, uint32 sector_lba)
{
    // Zero sector initially
    memset(fs->currentsector.sector, 0, FAT_SECTOR_SIZE);

    // FSI_LeadSig
    fs->currentsector.sector[0] = 0x52;
    fs->currentsector.sector[1] = 0x52;
    fs->currentsector.sector[2] = 0x61;
    fs->currentsector.sector[3] = 0x41;

    // FSI_StrucSig
    fs->currentsector.sector[484] = 0x72;
    fs->currentsector.sector[485] = 0x72;
    fs->currentsector.sector[486] = 0x41;
    fs->currentsector.sector[487] = 0x61;

    // FSI_Free_Count
    fs->currentsector.sector[488] = 0xFF;
    fs->currentsector.sector[489] = 0xFF;
    fs->currentsector.sector[490] = 0xFF;
    fs->currentsector.sector[491] = 0xFF;

    // FSI_Nxt_Free
    fs->currentsector.sector[492] = 0xFF;
    fs->currentsector.sector[493] = 0xFF;
    fs->currentsector.sector[494] = 0xFF;
    fs->currentsector.sector[495] = 0xFF;

    // Signature
    fs->currentsector.sector[510] = 0x55;
    fs->currentsector.sector[511] = 0xAA;

    if (fs->disk_io.write_media(sector_lba, fs->currentsector.sector, 1))
        return 1;
    else
        return 0;
}
//-----------------------------------------------------------------------------
// fatfs_erase_fat: Erase FAT table using fs details in fs struct
//-----------------------------------------------------------------------------
static int fatfs_erase_fat(struct fatfs *fs, int is_fat32)
{
    uint32 i;

    // Zero sector initially
    memset(fs->currentsector.sector, 0, FAT_SECTOR_SIZE);

    // Initialise default allocate / reserved clusters
    if (!is_fat32)
    {
        SET_16BIT_WORD(fs->currentsector.sector, 0, 0xFFF8);
        SET_16BIT_WORD(fs->currentsector.sector, 2, 0xFFFF);
    }
    else
    {
        SET_32BIT_WORD(fs->currentsector.sector, 0, 0x0FFFFFF8);
        SET_32BIT_WORD(fs->currentsector.sector, 4, 0xFFFFFFFF);
        SET_32BIT_WORD(fs->currentsector.sector, 8, 0x0FFFFFFF);
    }

    if (!fs->disk_io.write_media(fs->fat_begin_lba + 0, fs->currentsector.sector, 1))
        return 0;

    // Zero remaining FAT sectors
    memset(fs->currentsector.sector, 0, FAT_SECTOR_SIZE);
    for (i=1;i<fs->fat_sectors*fs->num_of_fats;i++)
        if (!fs->disk_io.write_media(fs->fat_begin_lba + i, fs->currentsector.sector, 1))
            return 0;

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_format_fat16: Format a FAT16 partition
//-----------------------------------------------------------------------------
int fatfs_format_fat16(struct fatfs *fs, uint32 volume_sectors, const char *name)
{
    fs->currentsector.address = FAT32_INVALID_CLUSTER;
    fs->currentsector.dirty = 0;

    fs->next_free_cluster = 0; // Invalid

    fatfs_fat_init(fs);

    // Make sure we have read + write functions
    if (!fs->disk_io.read_media || !fs->disk_io.write_media)
        return FAT_INIT_MEDIA_ACCESS_ERROR;

    // Volume is FAT16
    fs->fat_type = FAT_TYPE_16;

    // Not valid for FAT16
    fs->fs_info_sector = 0;
    fs->rootdir_first_cluster = 0;

    // Sector 0: Boot sector
    // NOTE: We don't need an MBR, it is a waste of a good sector!
    fs->lba_begin = 0;
    if (!fatfs_create_boot_sector(fs, fs->lba_begin, volume_sectors, name, 0))
        return 0;

    // For FAT16 (which this may be), rootdir_first_cluster is actuall rootdir_first_sector
    fs->rootdir_first_sector = fs->reserved_sectors + (fs->num_of_fats * fs->fat_sectors);
    fs->rootdir_sectors = ((fs->root_entry_count * 32) + (FAT_SECTOR_SIZE - 1)) / FAT_SECTOR_SIZE;

    // First FAT LBA address
    fs->fat_begin_lba = fs->lba_begin + fs->reserved_sectors;

    // The address of the first data cluster on this volume
    fs->cluster_begin_lba = fs->fat_begin_lba + (fs->num_of_fats * fs->fat_sectors);

    // Initialise FAT sectors
    if (!fatfs_erase_fat(fs, 0))
        return 0;

    // Erase Root directory
    if (!fatfs_erase_sectors(fs, fs->lba_begin + fs->rootdir_first_sector, fs->rootdir_sectors))
        return 0;

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_format_fat32: Format a FAT32 partition
//-----------------------------------------------------------------------------
int fatfs_format_fat32(struct fatfs *fs, uint32 volume_sectors, const char *name)
{
    fs->currentsector.address = FAT32_INVALID_CLUSTER;
    fs->currentsector.dirty = 0;

    fs->next_free_cluster = 0; // Invalid

    fatfs_fat_init(fs);

    // Make sure we have read + write functions
    if (!fs->disk_io.read_media || !fs->disk_io.write_media)
        return FAT_INIT_MEDIA_ACCESS_ERROR;

    // Volume is FAT32
    fs->fat_type = FAT_TYPE_32;

    // Basic defaults for normal FAT32 partitions
    fs->fs_info_sector = 1;
    fs->rootdir_first_cluster = 2;

    // Sector 0: Boot sector
    // NOTE: We don't need an MBR, it is a waste of a good sector!
    fs->lba_begin = 0;
    if (!fatfs_create_boot_sector(fs, fs->lba_begin, volume_sectors, name, 1))
        return 0;

    // First FAT LBA address
    fs->fat_begin_lba = fs->lba_begin + fs->reserved_sectors;

    // The address of the first data cluster on this volume
    fs->cluster_begin_lba = fs->fat_begin_lba + (fs->num_of_fats * fs->fat_sectors);

    // Initialise FSInfo sector
    if (!fatfs_create_fsinfo_sector(fs, fs->fs_info_sector))
        return 0;

    // Initialise FAT sectors
    if (!fatfs_erase_fat(fs, 1))
        return 0;

    // Erase Root directory
    if (!fatfs_erase_sectors(fs, fatfs_lba_of_cluster(fs, fs->rootdir_first_cluster), fs->sectors_per_cluster))
        return 0;

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_format: Format a partition with either FAT16 or FAT32 based on size
//-----------------------------------------------------------------------------
int fatfs_format(struct fatfs *fs, uint32 volume_sectors, const char *name)
{
    // 2GB - 32K limit for safe behaviour for FAT16
    if (volume_sectors <= 4194304)
        return fatfs_format_fat16(fs, volume_sectors, name);
    else
        return fatfs_format_fat32(fs, volume_sectors, name);
}
#endif /*FATFS_INC_FORMAT_SUPPORT*/
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// fatfs_lfn_cache_init: Clear long file name cache
//-----------------------------------------------------------------------------
void fatfs_lfn_cache_init(struct lfn_cache *lfn, int wipeTable)
{
    int i = 0;

    lfn->no_of_strings = 0;

#if FATFS_INC_LFN_SUPPORT

    // Zero out buffer also
    if (wipeTable)
        for (i=0;i<MAX_LONGFILENAME_ENTRIES;i++)
            memset(lfn->String[i], 0x00, MAX_LFN_ENTRY_LENGTH);
#endif
}
//-----------------------------------------------------------------------------
// fatfs_lfn_cache_entry - Function extracts long file name text from sector
// at a specific offset
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
void fatfs_lfn_cache_entry(struct lfn_cache *lfn, uint8 *entryBuffer)
{
    uint8 LFNIndex, i;
    LFNIndex = entryBuffer[0] & 0x1F;

    // Limit file name to cache size!
    if (LFNIndex > MAX_LONGFILENAME_ENTRIES)
        return ;

    // This is an error condition
    if (LFNIndex == 0)
        return ;

    if (lfn->no_of_strings == 0)
        lfn->no_of_strings = LFNIndex;

    lfn->String[LFNIndex-1][0] = entryBuffer[1];
    lfn->String[LFNIndex-1][1] = entryBuffer[3];
    lfn->String[LFNIndex-1][2] = entryBuffer[5];
    lfn->String[LFNIndex-1][3] = entryBuffer[7];
    lfn->String[LFNIndex-1][4] = entryBuffer[9];
    lfn->String[LFNIndex-1][5] = entryBuffer[0x0E];
    lfn->String[LFNIndex-1][6] = entryBuffer[0x10];
    lfn->String[LFNIndex-1][7] = entryBuffer[0x12];
    lfn->String[LFNIndex-1][8] = entryBuffer[0x14];
    lfn->String[LFNIndex-1][9] = entryBuffer[0x16];
    lfn->String[LFNIndex-1][10] = entryBuffer[0x18];
    lfn->String[LFNIndex-1][11] = entryBuffer[0x1C];
    lfn->String[LFNIndex-1][12] = entryBuffer[0x1E];

    for (i=0; i<MAX_LFN_ENTRY_LENGTH; i++)
        if (lfn->String[LFNIndex-1][i]==0xFF)
            lfn->String[LFNIndex-1][i] = 0x20; // Replace with spaces
}
#endif
//-----------------------------------------------------------------------------
// fatfs_lfn_cache_get: Get a reference to the long filename
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
char* fatfs_lfn_cache_get(struct lfn_cache *lfn)
{
    // Null terminate long filename
    if (lfn->no_of_strings == MAX_LONGFILENAME_ENTRIES)
        lfn->Null = '\0';
    else if (lfn->no_of_strings)
        lfn->String[lfn->no_of_strings][0] = '\0';
    else
        lfn->String[0][0] = '\0';

    return (char*)&lfn->String[0][0];
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_lfn_text: If LFN text entry found
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_entry_lfn_text(struct fat_dir_entry *entry)
{
    if ((entry->Attr & FILE_ATTR_LFN_TEXT) == FILE_ATTR_LFN_TEXT)
        return 1;
    else
        return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_lfn_invalid: If SFN found not relating to LFN
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_entry_lfn_invalid(struct fat_dir_entry *entry)
{
    if ( (entry->Name[0]==FILE_HEADER_BLANK)  ||
         (entry->Name[0]==FILE_HEADER_DELETED)||
         (entry->Attr==FILE_ATTR_VOLUME_ID) ||
         (entry->Attr & FILE_ATTR_SYSHID) )
        return 1;
    else
        return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_lfn_exists: If LFN exists and correlation SFN found
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_entry_lfn_exists(struct lfn_cache *lfn, struct fat_dir_entry *entry)
{
    if ( (entry->Attr!=FILE_ATTR_LFN_TEXT) &&
         (entry->Name[0]!=FILE_HEADER_BLANK) &&
         (entry->Name[0]!=FILE_HEADER_DELETED) &&
         (entry->Attr!=FILE_ATTR_VOLUME_ID) &&
         (!(entry->Attr&FILE_ATTR_SYSHID)) &&
         (lfn->no_of_strings) )
        return 1;
    else
        return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_sfn_only: If SFN only exists
//-----------------------------------------------------------------------------
int fatfs_entry_sfn_only(struct fat_dir_entry *entry)
{
    if ( (entry->Attr!=FILE_ATTR_LFN_TEXT) &&
         (entry->Name[0]!=FILE_HEADER_BLANK) &&
         (entry->Name[0]!=FILE_HEADER_DELETED) &&
         (entry->Attr!=FILE_ATTR_VOLUME_ID) &&
         (!(entry->Attr&FILE_ATTR_SYSHID)) )
        return 1;
    else
        return 0;
}
// TODO: FILE_ATTR_SYSHID ?!?!??!
//-----------------------------------------------------------------------------
// fatfs_entry_is_dir: Returns 1 if a directory
//-----------------------------------------------------------------------------
int fatfs_entry_is_dir(struct fat_dir_entry *entry)
{
    if (entry->Attr & FILE_TYPE_DIR)
        return 1;
    else
        return 0;
}
//-----------------------------------------------------------------------------
// fatfs_entry_is_file: Returns 1 is a file entry
//-----------------------------------------------------------------------------
int fatfs_entry_is_file(struct fat_dir_entry *entry)
{
    if (entry->Attr & FILE_TYPE_FILE)
        return 1;
    else
        return 0;
}
//-----------------------------------------------------------------------------
// fatfs_lfn_entries_required: Calculate number of 13 characters entries
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_lfn_entries_required(char *filename)
{
    int length = (int)strlen(filename);

    if (length)
        return (length + MAX_LFN_ENTRY_LENGTH - 1) / MAX_LFN_ENTRY_LENGTH;
    else
        return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_filename_to_lfn:
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
void fatfs_filename_to_lfn(char *filename, uint8 *buffer, int entry, uint8 sfnChk)
{
    int i;
    int nameIndexes[MAX_LFN_ENTRY_LENGTH] = {1,3,5,7,9,0x0E,0x10,0x12,0x14,0x16,0x18,0x1C,0x1E};

    // 13 characters entries
    int length = (int)strlen(filename);
    int entriesRequired = fatfs_lfn_entries_required(filename);

    // Filename offset
    int start = entry * MAX_LFN_ENTRY_LENGTH;

    // Initialise to zeros
    memset(buffer, 0x00, FAT_DIR_ENTRY_SIZE);

    // LFN entry number
    buffer[0] = (uint8)(((entriesRequired-1)==entry)?(0x40|(entry+1)):(entry+1));

    // LFN flag
    buffer[11] = 0x0F;

    // Checksum of short filename
    buffer[13] = sfnChk;

    // Copy to buffer
    for (i=0;i<MAX_LFN_ENTRY_LENGTH;i++)
    {
        if ( (start+i) < length )
            buffer[nameIndexes[i]] = filename[start+i];
        else if ( (start+i) == length )
            buffer[nameIndexes[i]] = 0x00;
        else
        {
            buffer[nameIndexes[i]] = 0xFF;
            buffer[nameIndexes[i]+1] = 0xFF;
        }
    }
}
#endif
//-----------------------------------------------------------------------------
// fatfs_sfn_create_entry: Create the short filename directory entry
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
void fatfs_sfn_create_entry(char *shortfilename, uint32 size, uint32 startCluster, struct fat_dir_entry *entry, int dir)
{
    int i;

    // Copy short filename
    for (i=0;i<FAT_SFN_SIZE_FULL;i++)
        entry->Name[i] = shortfilename[i];

    // Unless we have a RTC we might as well set these to 1980
    entry->CrtTimeTenth = 0x00;
    entry->CrtTime[1] = entry->CrtTime[0] = 0x00;
    entry->CrtDate[1] = 0x00;
    entry->CrtDate[0] = 0x20;
    entry->LstAccDate[1] = 0x00;
    entry->LstAccDate[0] = 0x20;
    entry->WrtTime[1] = entry->WrtTime[0] = 0x00;
    entry->WrtDate[1] = 0x00;
    entry->WrtDate[0] = 0x20;

    if (!dir)
        entry->Attr = FILE_TYPE_FILE;
    else
        entry->Attr = FILE_TYPE_DIR;

    entry->NTRes = 0x00;

    entry->FstClusHI = FAT_HTONS((uint16)((startCluster>>16) & 0xFFFF));
    entry->FstClusLO = FAT_HTONS((uint16)((startCluster>>0) & 0xFFFF));
    entry->FileSize = FAT_HTONL(size);
}
#endif
//-----------------------------------------------------------------------------
// fatfs_lfn_create_sfn: Create a padded SFN
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_lfn_create_sfn(char *sfn_output, char *filename)
{
    int i;
    int dotPos = -1;
    char ext[3];
    int pos;
    int len = (int)strlen(filename);

    // Invalid to start with .
    if (filename[0]=='.')
        return 0;

    memset(sfn_output, ' ', FAT_SFN_SIZE_FULL);
    memset(ext, ' ', 3);

    // Find dot seperator
    for (i = 0; i< len; i++)
    {
        if (filename[i]=='.')
            dotPos = i;
    }

    // Extract extensions
    if (dotPos!=-1)
    {
        // Copy first three chars of extension
        for (i = (dotPos+1); i < (dotPos+1+3); i++)
            if (i<len)
                ext[i-(dotPos+1)] = filename[i];

        // Shorten the length to the dot position
        len = dotPos;
    }

    // Add filename part
    pos = 0;
    for (i=0;i<len;i++)
    {
        if ( (filename[i]!=' ') && (filename[i]!='.') )
        {
            if (filename[i] >= 'a' && filename[i] <= 'z')
                sfn_output[pos++] = filename[i] - 'a' + 'A';
            else
                sfn_output[pos++] = filename[i];
        }

        // Fill upto 8 characters
        if (pos==FAT_SFN_SIZE_PARTIAL)
            break;
    }

    // Add extension part
    for (i=FAT_SFN_SIZE_PARTIAL;i<FAT_SFN_SIZE_FULL;i++)
    {
        if (ext[i-FAT_SFN_SIZE_PARTIAL] >= 'a' && ext[i-FAT_SFN_SIZE_PARTIAL] <= 'z')
            sfn_output[i] = ext[i-FAT_SFN_SIZE_PARTIAL] - 'a' + 'A';
        else
            sfn_output[i] = ext[i-FAT_SFN_SIZE_PARTIAL];
    }

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_itoa:
//-----------------------------------------------------------------------------
static void fatfs_itoa(uint32 num, char *s)
{
    char* cp;
    char outbuf[12];
    const char digits[] = "0123456789ABCDEF";

    // Build string backwards
    cp = outbuf;
    do
    {
        *cp++ = digits[(int)(num % 10)];
    }
    while ((num /= 10) > 0);

    *cp-- = 0;

    // Copy in forwards
    while (cp >= outbuf)
        *s++ = *cp--;

    *s = 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_lfn_generate_tail:
// sfn_input = Input short filename, spaced format & in upper case
// sfn_output = Output short filename with tail
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
#if FATFS_INC_WRITE_SUPPORT
int fatfs_lfn_generate_tail(char *sfn_output, char *sfn_input, uint32 tailNum)
{
    int tail_chars;
    char tail_str[12];

    if (tailNum > 99999)
        return 0;

    // Convert to number
    memset(tail_str, 0x00, sizeof(tail_str));
    tail_str[0] = '~';
    fatfs_itoa(tailNum, tail_str+1);

    // Copy in base filename
    memcpy(sfn_output, sfn_input, FAT_SFN_SIZE_FULL);

    // Overwrite with tail
    tail_chars = (int)strlen(tail_str);
    memcpy(sfn_output+(FAT_SFN_SIZE_PARTIAL-tail_chars), tail_str, tail_chars);

    return 1;
}
#endif
#endif
//-----------------------------------------------------------------------------
// fatfs_convert_from_fat_time: Convert FAT time to h/m/s
//-----------------------------------------------------------------------------
#if FATFS_INC_TIME_DATE_SUPPORT
void fatfs_convert_from_fat_time(uint16 fat_time, int *hours, int *minutes, int *seconds)
{
    *hours = (fat_time >> FAT_TIME_HOURS_SHIFT) & FAT_TIME_HOURS_MASK;
    *minutes = (fat_time >> FAT_TIME_MINUTES_SHIFT) & FAT_TIME_MINUTES_MASK;
    *seconds = (fat_time >> FAT_TIME_SECONDS_SHIFT) & FAT_TIME_SECONDS_MASK;
    *seconds = *seconds * FAT_TIME_SECONDS_SCALE;
}
//-----------------------------------------------------------------------------
// fatfs_convert_from_fat_date: Convert FAT date to d/m/y
//-----------------------------------------------------------------------------
void fatfs_convert_from_fat_date(uint16 fat_date, int *day, int *month, int *year)
{
    *day = (fat_date >> FAT_DATE_DAY_SHIFT) & FAT_DATE_DAY_MASK;
    *month = (fat_date >> FAT_DATE_MONTH_SHIFT) & FAT_DATE_MONTH_MASK;
    *year = (fat_date >> FAT_DATE_YEAR_SHIFT) & FAT_DATE_YEAR_MASK;
    *year = *year + FAT_DATE_YEAR_OFFSET;
}
//-----------------------------------------------------------------------------
// fatfs_convert_to_fat_time: Convert h/m/s to FAT time
//-----------------------------------------------------------------------------
uint16 fatfs_convert_to_fat_time(int hours, int minutes, int seconds)
{
    uint16 fat_time = 0;

    // Most FAT times are to a resolution of 2 seconds
    seconds /= FAT_TIME_SECONDS_SCALE;

    fat_time = (hours & FAT_TIME_HOURS_MASK) << FAT_TIME_HOURS_SHIFT;
    fat_time|= (minutes & FAT_TIME_MINUTES_MASK) << FAT_TIME_MINUTES_SHIFT;
    fat_time|= (seconds & FAT_TIME_SECONDS_MASK) << FAT_TIME_SECONDS_SHIFT;

    return fat_time;
}
//-----------------------------------------------------------------------------
// fatfs_convert_to_fat_date: Convert d/m/y to FAT date
//-----------------------------------------------------------------------------
uint16 fatfs_convert_to_fat_date(int day, int month, int year)
{
    uint16 fat_date = 0;

    // FAT dates are relative to 1980
    if (year >= FAT_DATE_YEAR_OFFSET)
        year -= FAT_DATE_YEAR_OFFSET;

    fat_date = (day & FAT_DATE_DAY_MASK) << FAT_DATE_DAY_SHIFT;
    fat_date|= (month & FAT_DATE_MONTH_MASK) << FAT_DATE_MONTH_SHIFT;
    fat_date|= (year & FAT_DATE_YEAR_MASK) << FAT_DATE_YEAR_SHIFT;

    return fat_date;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_print_sector:
//-----------------------------------------------------------------------------
#ifdef FATFS_DEBUG
void fatfs_print_sector(uint32 sector, uint8 *data)
{
    int i;
    int j;

    FAT_PRINTF(("Sector %d:\n", sector));

    for (i=0;i<FAT_SECTOR_SIZE;i++)
    {
        if (!((i) % 16))
        {
            FAT_PRINTF(("  %04d: ", i));
        }

        FAT_PRINTF(("%02x", data[i]));
        if (!((i+1) % 4))
        {
            FAT_PRINTF((" "));
        }

        if (!((i+1) % 16))
        {
            FAT_PRINTF(("   "));
            for (j=0;j<16;j++)
            {
                char ch = data[i-15+j];

                // Is printable?
                if (ch > 31 && ch < 127)
                {
                    FAT_PRINTF(("%c", ch));
                }
                else
                {
                    FAT_PRINTF(("."));
                }
            }

            FAT_PRINTF(("\n"));
        }
    }
}
#endif
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// fatfs_total_path_levels: Take a filename and path and count the sub levels
// of folders. E.g. C:\folder\file.zip = 1 level
// Acceptable input formats are:
//        c:\folder\file.zip
//        /dev/etc/samba.conf
// Returns: -1 = Error, 0 or more = Ok
//-----------------------------------------------------------------------------
int fatfs_total_path_levels(char *path)
{
    int levels = 0;
    char expectedchar;

    if (!path)
        return -1;

    // Acceptable formats:
    //  c:\folder\file.zip
    //  /dev/etc/samba.conf
    if (*path == '/')
    {
        expectedchar = '/';
        path++;
    }
    else if (path[1] == ':' || path[2] == '\\')
    {
        expectedchar = '\\';
        path += 3;
    }
    else
        return -1;

    // Count levels in path string
    while (*path)
    {
        // Fast forward through actual subdir text to next slash
        for (; *path; )
        {
            // If slash detected escape from for loop
            if (*path == expectedchar) { path++; break; }
            path++;
        }

        // Increase number of subdirs founds
        levels++;
    }

    // Subtract the file itself
    return levels-1;
}
//-----------------------------------------------------------------------------
// fatfs_get_substring: Get a substring from 'path' which contains the folder
// (or file) at the specified level.
// E.g. C:\folder\file.zip : Level 0 = C:\folder, Level 1 = file.zip
// Returns: -1 = Error, 0 = Ok
//-----------------------------------------------------------------------------
int fatfs_get_substring(char *path, int levelreq, char *output, int max_len)
{
    int i;
    int pathlen=0;
    int levels=0;
    int copypnt=0;
    char expectedchar;

    if (!path || max_len <= 0)
        return -1;

    // Acceptable formats:
    //  c:\folder\file.zip
    //  /dev/etc/samba.conf
    if (*path == '/')
    {
        expectedchar = '/';
        path++;
    }
    else if (path[1] == ':' || path[2] == '\\')
    {
        expectedchar = '\\';
        path += 3;
    }
    else
        return -1;

    // Get string length of path
    pathlen = (int)strlen (path);

    // Loop through the number of times as characters in 'path'
    for (i = 0; i<pathlen; i++)
    {
        // If a '\' is found then increase level
        if (*path == expectedchar) levels++;

        // If correct level and the character is not a '\' or '/' then copy text to 'output'
        if ( (levels == levelreq) && (*path != expectedchar) && (copypnt < (max_len-1)))
            output[copypnt++] = *path;

        // Increment through path string
        path++;
    }

    // Null Terminate
    output[copypnt] = '\0';

    // If a string was copied return 0 else return 1
    if (output[0] != '\0')
        return 0;    // OK
    else
        return -1;    // Error
}
//-----------------------------------------------------------------------------
// fatfs_split_path: Full path contains the passed in string.
// Returned is the path string and file Name string
// E.g. C:\folder\file.zip -> path = C:\folder  filename = file.zip
// E.g. C:\file.zip -> path = [blank]  filename = file.zip
//-----------------------------------------------------------------------------
int fatfs_split_path(char *full_path, char *path, int max_path, char *filename, int max_filename)
{
    int strindex;

    // Count the levels to the filepath
    int levels = fatfs_total_path_levels(full_path);
    if (levels == -1)
        return -1;

    // Get filename part of string
    if (fatfs_get_substring(full_path, levels, filename, max_filename) != 0)
        return -1;

    // If root file
    if (levels == 0)
        path[0] = '\0';
    else
    {
        strindex = (int)strlen(full_path) - (int)strlen(filename);
        if (strindex > max_path)
            strindex = max_path;

        memcpy(path, full_path, strindex);
        path[strindex-1] = '\0';
    }

    return 0;
}
//-----------------------------------------------------------------------------
// FileString_StrCmpNoCase: Compare two strings case with case sensitivity
//-----------------------------------------------------------------------------
static int FileString_StrCmpNoCase(char *s1, char *s2, int n)
{
    int diff;
    char a,b;

    while (n--)
    {
        a = *s1;
        b = *s2;

        // Make lower case if uppercase
        if ((a>='A') && (a<='Z'))
            a+= 32;
        if ((b>='A') && (b<='Z'))
            b+= 32;

        diff = a - b;

        // If different
        if (diff)
            return diff;

        // If run out of strings
        if ( (*s1 == 0) || (*s2 == 0) )
            break;

        s1++;
        s2++;
    }
    return 0;
}
//-----------------------------------------------------------------------------
// FileString_GetExtension: Get index to extension within filename
// Returns -1 if not found or index otherwise
//-----------------------------------------------------------------------------
static int FileString_GetExtension(char *str)
{
    int dotPos = -1;
    char *strSrc = str;

    // Find last '.' in string (if at all)
    while (*strSrc)
    {
        if (*strSrc=='.')
            dotPos = (int)(strSrc-str);

        strSrc++;
    }

    return dotPos;
}
//-----------------------------------------------------------------------------
// FileString_TrimLength: Get length of string excluding trailing spaces
// Returns -1 if not found or index otherwise
//-----------------------------------------------------------------------------
static int FileString_TrimLength(char *str, int strLen)
{
    int length = strLen;
    char *strSrc = str+strLen-1;

    // Find last non white space
    while (strLen != 0)
    {
        if (*strSrc == ' ')
            length = (int)(strSrc - str);
        else
            break;

        strSrc--;
        strLen--;
    }

    return length;
}
//-----------------------------------------------------------------------------
// fatfs_compare_names: Compare two filenames (without copying or changing origonals)
// Returns 1 if match, 0 if not
//-----------------------------------------------------------------------------
int fatfs_compare_names(char* strA, char* strB)
{
    char *ext1 = NULL;
    char *ext2 = NULL;
    int ext1Pos, ext2Pos;
    int file1Len, file2Len;

    // Get both files extension
    ext1Pos = FileString_GetExtension(strA);
    ext2Pos = FileString_GetExtension(strB);

    // NOTE: Extension position can be different for matching
    // filename if trailing space are present before it!
    // Check that if one has an extension, so does the other
    if ((ext1Pos==-1) && (ext2Pos!=-1))
        return 0;
    if ((ext2Pos==-1) && (ext1Pos!=-1))
        return 0;

    // If they both have extensions, compare them
    if (ext1Pos!=-1)
    {
        // Set pointer to start of extension
        ext1 = strA+ext1Pos+1;
        ext2 = strB+ext2Pos+1;

        // Verify that the file extension lengths match!
        if (strlen(ext1) != strlen(ext2))
            return 0;

        // If they dont match
        if (FileString_StrCmpNoCase(ext1, ext2, (int)strlen(ext1))!=0)
            return 0;

        // Filelength is upto extensions
        file1Len = ext1Pos;
        file2Len = ext2Pos;
    }
    // No extensions
    else
    {
        // Filelength is actual filelength
        file1Len = (int)strlen(strA);
        file2Len = (int)strlen(strB);
    }

    // Find length without trailing spaces (before ext)
    file1Len = FileString_TrimLength(strA, file1Len);
    file2Len = FileString_TrimLength(strB, file2Len);

    // Check the file lengths match
    if (file1Len!=file2Len)
        return 0;

    // Compare main part of filenames
    if (FileString_StrCmpNoCase(strA, strB, file1Len)!=0)
        return 0;
    else
        return 1;
}
//-----------------------------------------------------------------------------
// fatfs_string_ends_with_slash: Does the string end with a slash (\ or /)
//-----------------------------------------------------------------------------
int fatfs_string_ends_with_slash(char *path)
{
    if (path)
    {
        while (*path)
        {
            // Last character?
            if (!(*(path+1)))
            {
                if (*path == '\\' || *path == '/')
                    return 1;
            }

            path++;
        }
    }

    return 0;
}
//-----------------------------------------------------------------------------
// fatfs_get_sfn_display_name: Get display name for SFN entry
//-----------------------------------------------------------------------------
int fatfs_get_sfn_display_name(char* out, char* in)
{
    int len = 0;
    while (*in && len <= 11)
    {
        char a = *in++;

        if (a == ' ')
            continue;
        // Make lower case if uppercase
        else if ((a>='A') && (a<='Z'))
            a+= 32;

        *out++ = a;
        len++;
    }

    *out = '\0';
    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_get_extension: Get extension of filename passed in 'filename'.
// Returned extension is always lower case.
// Returns: 1 if ok, 0 if not.
//-----------------------------------------------------------------------------
int fatfs_get_extension(char* filename, char* out, int maxlen)
{
    int len = 0;

    // Get files extension offset
    int ext_pos = FileString_GetExtension(filename);

    if (ext_pos > 0 && out && maxlen)
    {
        filename += ext_pos + 1;

        while (*filename && len < (maxlen-1))
        {
            char a = *filename++;

            // Make lowercase if uppercase
            if ((a>='A') && (a<='Z'))
                a+= 32;

            *out++ = a;
            len++;
        }

        *out = '\0';
        return 1;
    }

    return 0;
}
//-----------------------------------------------------------------------------
// fatfs_create_path_string: Append path & filename to create file path string.
// Returns: 1 if ok, 0 if not.
//-----------------------------------------------------------------------------
int fatfs_create_path_string(char* path, char *filename, char* out, int maxlen)
{
    int len = 0;
    char last = 0;
    char seperator = '/';

    if (path && filename && out && maxlen > 0)
    {
        while (*path && len < (maxlen-2))
        {
            last = *path++;
            if (last == '\\')
                seperator = '\\';
            *out++ = last;
            len++;
        }

        // Add a seperator if trailing one not found
        if (last != '\\' && last != '/')
            *out++ = seperator;

        while (*filename && len < (maxlen-1))
        {
            *out++ = *filename++;
            len++;
        }

        *out = '\0';

        return 1;
    }

    return 0;
}
//-----------------------------------------------------------------------------
// Test Bench
//-----------------------------------------------------------------------------
#ifdef FAT_STRING_TESTBENCH
void main(void)
{
    char output[255];
    char output2[255];

    assert(fatfs_total_path_levels("C:\\folder\\file.zip") == 1);
    assert(fatfs_total_path_levels("C:\\file.zip") == 0);
    assert(fatfs_total_path_levels("C:\\folder\\folder2\\file.zip") == 2);
    assert(fatfs_total_path_levels("C:\\") == -1);
    assert(fatfs_total_path_levels("") == -1);
    assert(fatfs_total_path_levels("/dev/etc/file.zip") == 2);
    assert(fatfs_total_path_levels("/dev/file.zip") == 1);

    assert(fatfs_get_substring("C:\\folder\\file.zip", 0, output, sizeof(output)) == 0);
    assert(strcmp(output, "folder") == 0);

    assert(fatfs_get_substring("C:\\folder\\file.zip", 1, output, sizeof(output)) == 0);
    assert(strcmp(output, "file.zip") == 0);

    assert(fatfs_get_substring("/dev/etc/file.zip", 0, output, sizeof(output)) == 0);
    assert(strcmp(output, "dev") == 0);

    assert(fatfs_get_substring("/dev/etc/file.zip", 1, output, sizeof(output)) == 0);
    assert(strcmp(output, "etc") == 0);

    assert(fatfs_get_substring("/dev/etc/file.zip", 2, output, sizeof(output)) == 0);
    assert(strcmp(output, "file.zip") == 0);

    assert(fatfs_split_path("C:\\folder\\file.zip", output, sizeof(output), output2, sizeof(output2)) == 0);
    assert(strcmp(output, "C:\\folder") == 0);
    assert(strcmp(output2, "file.zip") == 0);

    assert(fatfs_split_path("C:\\file.zip", output, sizeof(output), output2, sizeof(output2)) == 0);
    assert(output[0] == 0);
    assert(strcmp(output2, "file.zip") == 0);

    assert(fatfs_split_path("/dev/etc/file.zip", output, sizeof(output), output2, sizeof(output2)) == 0);
    assert(strcmp(output, "/dev/etc") == 0);
    assert(strcmp(output2, "file.zip") == 0);

    assert(FileString_GetExtension("C:\\file.zip") == strlen("C:\\file"));
    assert(FileString_GetExtension("C:\\file.zip.ext") == strlen("C:\\file.zip"));
    assert(FileString_GetExtension("C:\\file.zip.") == strlen("C:\\file.zip"));

    assert(FileString_TrimLength("C:\\file.zip", strlen("C:\\file.zip")) == strlen("C:\\file.zip"));
    assert(FileString_TrimLength("C:\\file.zip   ", strlen("C:\\file.zip   ")) == strlen("C:\\file.zip"));
    assert(FileString_TrimLength("   ", strlen("   ")) == 0);

    assert(fatfs_compare_names("C:\\file.ext", "C:\\file.ext") == 1);
    assert(fatfs_compare_names("C:\\file2.ext", "C:\\file.ext") == 0);
    assert(fatfs_compare_names("C:\\file  .ext", "C:\\file.ext") == 1);
    assert(fatfs_compare_names("C:\\file  .ext", "C:\\file2.ext") == 0);

    assert(fatfs_string_ends_with_slash("C:\\folder") == 0);
    assert(fatfs_string_ends_with_slash("C:\\folder\\") == 1);
    assert(fatfs_string_ends_with_slash("/path") == 0);
    assert(fatfs_string_ends_with_slash("/path/a") == 0);
    assert(fatfs_string_ends_with_slash("/path/") == 1);

    assert(fatfs_get_extension("/mypath/file.wav", output, 4) == 1);
    assert(strcmp(output, "wav") == 0);
    assert(fatfs_get_extension("/mypath/file.WAV", output, 4) == 1);
    assert(strcmp(output, "wav") == 0);
    assert(fatfs_get_extension("/mypath/file.zip", output, 4) == 1);
    assert(strcmp(output, "ext") != 0);

    assert(fatfs_create_path_string("/mydir1", "myfile.txt", output, sizeof(output)) == 1);
    assert(strcmp(output, "/mydir1/myfile.txt") == 0);
    assert(fatfs_create_path_string("/mydir2/", "myfile2.txt", output, sizeof(output)) == 1);
    assert(strcmp(output, "/mydir2/myfile2.txt") == 0);
    assert(fatfs_create_path_string("C:\\mydir3", "myfile3.txt", output, sizeof(output)) == 1);
    assert(strcmp(output, "C:\\mydir3\\myfile3.txt") == 0);
}
#endif
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

#ifndef FAT_BUFFERS
    #define FAT_BUFFERS 1
#endif

#ifndef FAT_BUFFER_SECTORS
    #define FAT_BUFFER_SECTORS 1
#endif

#if FAT_BUFFERS < 1 || FAT_BUFFER_SECTORS < 1
    #error "FAT_BUFFERS & FAT_BUFFER_SECTORS must be at least 1"
#endif

//-----------------------------------------------------------------------------
//                            FAT Sector Buffer
//-----------------------------------------------------------------------------
#define FAT32_GET_32BIT_WORD(pbuf, location)        ( GET_32BIT_WORD(pbuf->ptr, location) )
#define FAT32_SET_32BIT_WORD(pbuf, location, value) { SET_32BIT_WORD(pbuf->ptr, location, value); pbuf->dirty = 1; }
#define FAT16_GET_16BIT_WORD(pbuf, location)        ( GET_16BIT_WORD(pbuf->ptr, location) )
#define FAT16_SET_16BIT_WORD(pbuf, location, value) { SET_16BIT_WORD(pbuf->ptr, location, value); pbuf->dirty = 1; }

//-----------------------------------------------------------------------------
// fatfs_fat_init:
//-----------------------------------------------------------------------------
void fatfs_fat_init(struct fatfs *fs)
{
    int i;

    // FAT buffer chain head
    fs->fat_buffer_head = NULL;

    for (i=0;i<FAT_BUFFERS;i++)
    {
        // Initialise buffers to invalid
        fs->fat_buffers[i].address = FAT32_INVALID_CLUSTER;
        fs->fat_buffers[i].dirty = 0;
        memset(fs->fat_buffers[i].sector, 0x00, sizeof(fs->fat_buffers[i].sector));
        fs->fat_buffers[i].ptr = NULL;

        // Add to head of queue
        fs->fat_buffers[i].next = fs->fat_buffer_head;
        fs->fat_buffer_head = &fs->fat_buffers[i];
    }
}
//-----------------------------------------------------------------------------
// fatfs_fat_writeback: Writeback 'dirty' FAT sectors to disk
//-----------------------------------------------------------------------------
static int fatfs_fat_writeback(struct fatfs *fs, struct fat_buffer *pcur)
{
    if (pcur)
    {
        // Writeback sector if changed
        if (pcur->dirty)
        {
            if (fs->disk_io.write_media)
            {
                uint32 sectors = FAT_BUFFER_SECTORS;
                uint32 offset = pcur->address - fs->fat_begin_lba;

                // Limit to sectors used for the FAT
                if ((offset + FAT_BUFFER_SECTORS) <= fs->fat_sectors)
                    sectors = FAT_BUFFER_SECTORS;
                else
                    sectors = fs->fat_sectors - offset;

                if (!fs->disk_io.write_media(pcur->address, pcur->sector, sectors))
                    return 0;
            }

            pcur->dirty = 0;
        }

        return 1;
    }
    else
        return 0;
}
//-----------------------------------------------------------------------------
// fatfs_fat_read_sector: Read a FAT sector
//-----------------------------------------------------------------------------
static struct fat_buffer *fatfs_fat_read_sector(struct fatfs *fs, uint32 sector)
{
    struct fat_buffer *last = NULL;
    struct fat_buffer *pcur = fs->fat_buffer_head;

    // Itterate through sector buffer list
    while (pcur)
    {
        // Sector within this buffer?
        if ((sector >= pcur->address) && (sector < (pcur->address + FAT_BUFFER_SECTORS)))
            break;

        // End of list?
        if (pcur->next == NULL)
        {
            // Remove buffer from list
            if (last)
                last->next = NULL;
            // We the first and last buffer in the chain?
            else
                fs->fat_buffer_head = NULL;
        }

        last = pcur;
        pcur = pcur->next;
    }

    // We found the sector already in FAT buffer chain
    if (pcur)
    {
        pcur->ptr = (uint8 *)(pcur->sector + ((sector - pcur->address) * FAT_SECTOR_SIZE));
        return pcur;
    }

    // Else, we removed the last item from the list
    pcur = last;

    // Add to start of sector buffer list (now newest sector)
    pcur->next = fs->fat_buffer_head;
    fs->fat_buffer_head = pcur;

    // Writeback sector if changed
    if (pcur->dirty)
        if (!fatfs_fat_writeback(fs, pcur))
            return 0;

    // Address is now new sector
    pcur->address = sector;

    // Read next sector
    if (!fs->disk_io.read_media(pcur->address, pcur->sector, FAT_BUFFER_SECTORS))
    {
        // Read failed, invalidate buffer address
        pcur->address = FAT32_INVALID_CLUSTER;
        return NULL;
    }

    pcur->ptr = pcur->sector;
    return pcur;
}
//-----------------------------------------------------------------------------
// fatfs_fat_purge: Purge 'dirty' FAT sectors to disk
//-----------------------------------------------------------------------------
int fatfs_fat_purge(struct fatfs *fs)
{
    struct fat_buffer *pcur = fs->fat_buffer_head;

    // Itterate through sector buffer list
    while (pcur)
    {
        // Writeback sector if changed
        if (pcur->dirty)
            if (!fatfs_fat_writeback(fs, pcur))
                return 0;

        pcur = pcur->next;
    }

    return 1;
}

//-----------------------------------------------------------------------------
//                        General FAT Table Operations
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// fatfs_find_next_cluster: Return cluster number of next cluster in chain by
// reading FAT table and traversing it. Return 0xffffffff for end of chain.
//-----------------------------------------------------------------------------
uint32 fatfs_find_next_cluster(struct fatfs *fs, uint32 current_cluster)
{
    uint32 fat_sector_offset, position;
    uint32 nextcluster;
    struct fat_buffer *pbuf;

    // Why is '..' labelled with cluster 0 when it should be 2 ??
    if (current_cluster == 0)
        current_cluster = 2;

    // Find which sector of FAT table to read
    if (fs->fat_type == FAT_TYPE_16)
        fat_sector_offset = current_cluster / 256;
    else
        fat_sector_offset = current_cluster / 128;

    // Read FAT sector into buffer
    pbuf = fatfs_fat_read_sector(fs, fs->fat_begin_lba+fat_sector_offset);
    if (!pbuf)
        return (FAT32_LAST_CLUSTER);

    if (fs->fat_type == FAT_TYPE_16)
    {
        // Find 32 bit entry of current sector relating to cluster number
        position = (current_cluster - (fat_sector_offset * 256)) * 2;

        // Read Next Clusters value from Sector Buffer
        nextcluster = FAT16_GET_16BIT_WORD(pbuf, (uint16)position);

        // If end of chain found
        if (nextcluster >= 0xFFF8 && nextcluster <= 0xFFFF)
            return (FAT32_LAST_CLUSTER);
    }
    else
    {
        // Find 32 bit entry of current sector relating to cluster number
        position = (current_cluster - (fat_sector_offset * 128)) * 4;

        // Read Next Clusters value from Sector Buffer
        nextcluster = FAT32_GET_32BIT_WORD(pbuf, (uint16)position);

        // Mask out MS 4 bits (its 28bit addressing)
        nextcluster = nextcluster & 0x0FFFFFFF;

        // If end of chain found
        if (nextcluster >= 0x0FFFFFF8 && nextcluster <= 0x0FFFFFFF)
            return (FAT32_LAST_CLUSTER);
    }

    // Else return next cluster
    return (nextcluster);
}
//-----------------------------------------------------------------------------
// fatfs_set_fs_info_next_free_cluster: Write the next free cluster to the FSINFO table
//-----------------------------------------------------------------------------
void fatfs_set_fs_info_next_free_cluster(struct fatfs *fs, uint32 newValue)
{
    if (fs->fat_type == FAT_TYPE_16)
        ;
    else
    {
        // Load sector to change it
        struct fat_buffer *pbuf = fatfs_fat_read_sector(fs, fs->lba_begin+fs->fs_info_sector);
        if (!pbuf)
            return ;

        // Change
        FAT32_SET_32BIT_WORD(pbuf, 492, newValue);
        fs->next_free_cluster = newValue;

        // Write back FSINFO sector to disk
        if (fs->disk_io.write_media)
            fs->disk_io.write_media(pbuf->address, pbuf->sector, 1);

        // Invalidate cache entry
        pbuf->address = FAT32_INVALID_CLUSTER;
        pbuf->dirty = 0;
    }
}
//-----------------------------------------------------------------------------
// fatfs_find_blank_cluster: Find a free cluster entry by reading the FAT
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_find_blank_cluster(struct fatfs *fs, uint32 start_cluster, uint32 *free_cluster)
{
    uint32 fat_sector_offset, position;
    uint32 nextcluster;
    uint32 current_cluster = start_cluster;
    struct fat_buffer *pbuf;

    do
    {
        // Find which sector of FAT table to read
        if (fs->fat_type == FAT_TYPE_16)
            fat_sector_offset = current_cluster / 256;
        else
            fat_sector_offset = current_cluster / 128;

        if ( fat_sector_offset < fs->fat_sectors)
        {
            // Read FAT sector into buffer
            pbuf = fatfs_fat_read_sector(fs, fs->fat_begin_lba+fat_sector_offset);
            if (!pbuf)
                return 0;

            if (fs->fat_type == FAT_TYPE_16)
            {
                // Find 32 bit entry of current sector relating to cluster number
                position = (current_cluster - (fat_sector_offset * 256)) * 2;

                // Read Next Clusters value from Sector Buffer
                nextcluster = FAT16_GET_16BIT_WORD(pbuf, (uint16)position);
            }
            else
            {
                // Find 32 bit entry of current sector relating to cluster number
                position = (current_cluster - (fat_sector_offset * 128)) * 4;

                // Read Next Clusters value from Sector Buffer
                nextcluster = FAT32_GET_32BIT_WORD(pbuf, (uint16)position);

                // Mask out MS 4 bits (its 28bit addressing)
                nextcluster = nextcluster & 0x0FFFFFFF;
            }

            if (nextcluster !=0 )
                current_cluster++;
        }
        else
            // Otherwise, run out of FAT sectors to check...
            return 0;
    }
    while (nextcluster != 0x0);

    // Found blank entry
    *free_cluster = current_cluster;
    return 1;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_fat_set_cluster: Set a cluster link in the chain. NOTE: Immediate
// write (slow).
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_fat_set_cluster(struct fatfs *fs, uint32 cluster, uint32 next_cluster)
{
    struct fat_buffer *pbuf;
    uint32 fat_sector_offset, position;

    // Find which sector of FAT table to read
    if (fs->fat_type == FAT_TYPE_16)
        fat_sector_offset = cluster / 256;
    else
        fat_sector_offset = cluster / 128;

    // Read FAT sector into buffer
    pbuf = fatfs_fat_read_sector(fs, fs->fat_begin_lba+fat_sector_offset);
    if (!pbuf)
        return 0;

    if (fs->fat_type == FAT_TYPE_16)
    {
        // Find 16 bit entry of current sector relating to cluster number
        position = (cluster - (fat_sector_offset * 256)) * 2;

        // Write Next Clusters value to Sector Buffer
        FAT16_SET_16BIT_WORD(pbuf, (uint16)position, ((uint16)next_cluster));
    }
    else
    {
        // Find 32 bit entry of current sector relating to cluster number
        position = (cluster - (fat_sector_offset * 128)) * 4;

        // Write Next Clusters value to Sector Buffer
        FAT32_SET_32BIT_WORD(pbuf, (uint16)position, next_cluster);
    }

    return 1;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_free_cluster_chain: Follow a chain marking each element as free
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_free_cluster_chain(struct fatfs *fs, uint32 start_cluster)
{
    uint32 last_cluster;
    uint32 next_cluster = start_cluster;

    // Loop until end of chain
    while ( (next_cluster != FAT32_LAST_CLUSTER) && (next_cluster != 0x00000000) )
    {
        last_cluster = next_cluster;

        // Find next link
        next_cluster = fatfs_find_next_cluster(fs, next_cluster);

        // Clear last link
        fatfs_fat_set_cluster(fs, last_cluster, 0x00000000);
    }

    return 1;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_fat_add_cluster_to_chain: Follow a chain marking and then add a new entry
// to the current tail.
//-----------------------------------------------------------------------------
#if FATFS_INC_WRITE_SUPPORT
int fatfs_fat_add_cluster_to_chain(struct fatfs *fs, uint32 start_cluster, uint32 newEntry)
{
    uint32 last_cluster = FAT32_LAST_CLUSTER;
    uint32 next_cluster = start_cluster;

    if (start_cluster == FAT32_LAST_CLUSTER)
        return 0;

    // Loop until end of chain
    while ( next_cluster != FAT32_LAST_CLUSTER )
    {
        last_cluster = next_cluster;

        // Find next link
        next_cluster = fatfs_find_next_cluster(fs, next_cluster);
        if (!next_cluster)
            return 0;
    }

    // Add link in for new cluster
    fatfs_fat_set_cluster(fs, last_cluster, newEntry);

    // Mark new cluster as end of chain
    fatfs_fat_set_cluster(fs, newEntry, FAT32_LAST_CLUSTER);

    return 1;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_count_free_clusters:
//-----------------------------------------------------------------------------
uint32 fatfs_count_free_clusters(struct fatfs *fs)
{
    uint32 i,j;
    uint32 count = 0;
    struct fat_buffer *pbuf;

    for (i = 0; i < fs->fat_sectors; i++)
    {
        // Read FAT sector into buffer
        pbuf = fatfs_fat_read_sector(fs, fs->fat_begin_lba + i);
        if (!pbuf)
            break;

        for (j = 0; j < FAT_SECTOR_SIZE; )
        {
            if (fs->fat_type == FAT_TYPE_16)
            {
                if (FAT16_GET_16BIT_WORD(pbuf, (uint16)j) == 0)
                    count++;

                j += 2;
            }
            else
            {
                if (FAT32_GET_32BIT_WORD(pbuf, (uint16)j) == 0)
                    count++;

                j += 4;
            }
        }
    }

    return count;
}
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//                            FAT16/32 File IO Library
//                                    V2.6
//                              Ultra-Embedded.com
//                            Copyright 2003 - 2012
//
//                         Email: admin@ultra-embedded.com
//
//                                License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

#if FATFS_INC_WRITE_SUPPORT
//-----------------------------------------------------------------------------
// fatfs_add_free_space: Allocate another cluster of free space to the end
// of a files cluster chain.
//-----------------------------------------------------------------------------
int fatfs_add_free_space(struct fatfs *fs, uint32 *startCluster, uint32 clusters)
{
    uint32 i;
    uint32 nextcluster;
    uint32 start = *startCluster;

    // Set the next free cluster hint to unknown
    if (fs->next_free_cluster != FAT32_LAST_CLUSTER)
        fatfs_set_fs_info_next_free_cluster(fs, FAT32_LAST_CLUSTER);

    for (i=0;i<clusters;i++)
    {
        // Start looking for free clusters from the beginning
        if (fatfs_find_blank_cluster(fs, fs->rootdir_first_cluster, &nextcluster))
        {
            // Point last to this
            fatfs_fat_set_cluster(fs, start, nextcluster);

            // Point this to end of file
            fatfs_fat_set_cluster(fs, nextcluster, FAT32_LAST_CLUSTER);

            // Adjust argument reference
            start = nextcluster;
            if (i == 0)
                *startCluster = nextcluster;
        }
        else
            return 0;
    }

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_allocate_free_space: Add an ammount of free space to a file either from
// 'startCluster' if newFile = false, or allocating a new start to the chain if
// newFile = true.
//-----------------------------------------------------------------------------
int fatfs_allocate_free_space(struct fatfs *fs, int newFile, uint32 *startCluster, uint32 size)
{
    uint32 clusterSize;
    uint32 clusterCount;
    uint32 nextcluster;

    if (size==0)
        return 0;

    // Set the next free cluster hint to unknown
    if (fs->next_free_cluster != FAT32_LAST_CLUSTER)
        fatfs_set_fs_info_next_free_cluster(fs, FAT32_LAST_CLUSTER);

    // Work out size and clusters
    clusterSize = fs->sectors_per_cluster * FAT_SECTOR_SIZE;
    clusterCount = (size / clusterSize);

    // If any left over
    if (size-(clusterSize*clusterCount))
        clusterCount++;

    // Allocated first link in the chain if a new file
    if (newFile)
    {
        if (!fatfs_find_blank_cluster(fs, fs->rootdir_first_cluster, &nextcluster))
            return 0;

        // If this is all that is needed then all done
        if (clusterCount==1)
        {
            fatfs_fat_set_cluster(fs, nextcluster, FAT32_LAST_CLUSTER);
            *startCluster = nextcluster;
            return 1;
        }
    }
    // Allocate from end of current chain (startCluster is end of chain)
    else
        nextcluster = *startCluster;

    if (!fatfs_add_free_space(fs, &nextcluster, clusterCount))
            return 0;

    return 1;
}
//-----------------------------------------------------------------------------
// fatfs_find_free_dir_offset: Find a free space in the directory for a new entry
// which takes up 'entryCount' blocks (or allocate some more)
//-----------------------------------------------------------------------------
static int fatfs_find_free_dir_offset(struct fatfs *fs, uint32 dirCluster, int entryCount, uint32 *pSector, uint8 *pOffset)
{
    struct fat_dir_entry *directoryEntry;
    uint8 item=0;
    uint16 recordoffset = 0;
    uint8 i=0;
    int x=0;
    int possible_spaces = 0;
    int start_recorded = 0;

    // No entries required?
    if (entryCount == 0)
        return 0;

    // Main cluster following loop
    while (1)
    {
        // Read sector
        if (fatfs_sector_reader(fs, dirCluster, x++, 0))
        {
            // Analyse Sector
            for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Create the multiplier for sector access
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // Overlay directory entry over buffer
                directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);

                // LFN Entry
                if (fatfs_entry_lfn_text(directoryEntry))
                {
                    // First entry?
                    if (possible_spaces == 0)
                    {
                        // Store start
                        *pSector = x-1;
                        *pOffset = item;
                        start_recorded = 1;
                    }

                    // Increment the count in-case the file turns
                    // out to be deleted...
                    possible_spaces++;
                }
                // SFN Entry
                else
                {
                    // Has file been deleted?
                    if (fs->currentsector.sector[recordoffset] == FILE_HEADER_DELETED)
                    {
                        // First entry?
                        if (possible_spaces == 0)
                        {
                            // Store start
                            *pSector = x-1;
                            *pOffset = item;
                            start_recorded = 1;
                        }

                        possible_spaces++;

                        // We have found enough space?
                        if (possible_spaces >= entryCount)
                            return 1;

                        // Else continue counting until we find a valid entry!
                    }
                    // Is the file entry empty?
                    else if (fs->currentsector.sector[recordoffset] == FILE_HEADER_BLANK)
                    {
                        // First entry?
                        if (possible_spaces == 0)
                        {
                            // Store start
                            *pSector = x-1;
                            *pOffset = item;
                            start_recorded = 1;
                        }

                        // Increment the blank entries count
                        possible_spaces++;

                        // We have found enough space?
                        if (possible_spaces >= entryCount)
                            return 1;
                    }
                    // File entry is valid
                    else
                    {
                        // Reset all flags
                        possible_spaces = 0;
                        start_recorded = 0;
                    }
                }
            } // End of for
        } // End of if
        // Run out of free space in the directory, allocate some more
        else
        {
            uint32 newCluster;

            // Get a new cluster for directory
            if (!fatfs_find_blank_cluster(fs, fs->rootdir_first_cluster, &newCluster))
                return 0;

            // Add cluster to end of directory tree
            if (!fatfs_fat_add_cluster_to_chain(fs, dirCluster, newCluster))
                return 0;

            // Erase new directory cluster
            memset(fs->currentsector.sector, 0x00, FAT_SECTOR_SIZE);
            for (i=0;i<fs->sectors_per_cluster;i++)
            {
                if (!fatfs_write_sector(fs, newCluster, i, 0))
                    return 0;
            }

            // If non of the name fitted on previous sectors
            if (!start_recorded)
            {
                // Store start
                *pSector = (x-1);
                *pOffset = 0;
                start_recorded = 1;
            }

            return 1;
        }
    } // End of while loop

    return 0;
}
//-----------------------------------------------------------------------------
// fatfs_add_file_entry: Add a directory entry to a location found by FindFreeOffset
//-----------------------------------------------------------------------------
int fatfs_add_file_entry(struct fatfs *fs, uint32 dirCluster, char *filename, char *shortfilename, uint32 startCluster, uint32 size, int dir)
{
    uint8 item=0;
    uint16 recordoffset = 0;
    uint8 i=0;
    uint32 x=0;
    int entryCount;
    struct fat_dir_entry shortEntry;
    int dirtySector = 0;

    uint32 dirSector = 0;
    uint8 dirOffset = 0;
    int foundEnd = 0;

    uint8 checksum;
    uint8 *pSname;

    // No write access?
    if (!fs->disk_io.write_media)
        return 0;

#if FATFS_INC_LFN_SUPPORT
    // How many LFN entries are required?
    // NOTE: We always request one LFN even if it would fit in a SFN!
    entryCount = fatfs_lfn_entries_required(filename);
    if (!entryCount)
        return 0;
#else
    entryCount = 0;
#endif

    // Find space in the directory for this filename (or allocate some more)
    // NOTE: We need to find space for at least the LFN + SFN (or just the SFN if LFNs not supported).
    if (!fatfs_find_free_dir_offset(fs, dirCluster, entryCount + 1, &dirSector, &dirOffset))
        return 0;

    // Generate checksum of short filename
    pSname = (uint8*)shortfilename;
    checksum = 0;
    for (i=11; i!=0; i--) checksum = ((checksum & 1) ? 0x80 : 0) + (checksum >> 1) + *pSname++;

    // Start from current sector where space was found!
    x = dirSector;

    // Main cluster following loop
    while (1)
    {
        // Read sector
        if (fatfs_sector_reader(fs, dirCluster, x++, 0))
        {
            // Analyse Sector
            for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
            {
                // Create the multiplier for sector access
                recordoffset = FAT_DIR_ENTRY_SIZE * item;

                // If the start position for the entry has been found
                if (foundEnd==0)
                    if ( (dirSector==(x-1)) && (dirOffset==item) )
                        foundEnd = 1;

                // Start adding filename
                if (foundEnd)
                {
                    if (entryCount==0)
                    {
                        // Short filename
                        fatfs_sfn_create_entry(shortfilename, size, startCluster, &shortEntry, dir);

#if FATFS_INC_TIME_DATE_SUPPORT
                        // Update create, access & modify time & date
                        fatfs_update_timestamps(&shortEntry, 1, 1, 1);
#endif

                        memcpy(&fs->currentsector.sector[recordoffset], &shortEntry, sizeof(shortEntry));

                        // Writeback
                        return fs->disk_io.write_media(fs->currentsector.address, fs->currentsector.sector, 1);
                    }
#if FATFS_INC_LFN_SUPPORT
                    else
                    {
                        entryCount--;

                        // Copy entry to directory buffer
                        fatfs_filename_to_lfn(filename, &fs->currentsector.sector[recordoffset], entryCount, checksum);
                        dirtySector = 1;
                    }
#endif
                }
            } // End of if

            // Write back to disk before loading another sector
            if (dirtySector)
            {
                if (!fs->disk_io.write_media(fs->currentsector.address, fs->currentsector.sector, 1))
                    return 0;

                dirtySector = 0;
            }
        }
        else
            return 0;
    } // End of while loop

    return 0;
}
#endif


//--------------------------------------------------------------------------
// timer_init:
//--------------------------------------------------------------------------
void timer_init(void)
{
    //#error "Fill in timer implementation"
}
//--------------------------------------------------------------------------
// timer_sleep:
//--------------------------------------------------------------------------
void timer_sleep(int timeMs)
{
    t_time t = timer_now();

    while (timer_diff(timer_now(), t) < timeMs)
        ;
}
//--------------------------------------------------------------------------
// timer_now: Return time now in ms
//--------------------------------------------------------------------------
t_time timer_now(void)
{
//    #error "Fill in timer implementation"
    return milliseconds();

//  return 0;
}

//-----------------------------------------------------------------
// spi_init: Initialise SPI master
//-----------------------------------------------------------------
void spi_init_(void)           
{         
  //    #error "Fill in SPI controller implementation"
  spi_init();
}
//-----------------------------------------------------------------
// spi_cs: Set chip select
//-----------------------------------------------------------------
void spi_cs(uint32_t value)
{
  //#error "Fill in SPI controller implementation"
  set_spi_cs(value);
}
//-----------------------------------------------------------------
// spi_sendrecv: Send or receive a character
//-----------------------------------------------------------------
uint8_t spi_sendrecv(uint8_t data)
{
  //  #error "Fill in SPI controller implementation"
    // 1. Write data to SPI Tx FIFO
    // 2. Wait for Tx complete
    // 3. Read SPI Rx FIFO and return
  return spi_send(data);
}
//-----------------------------------------------------------------
// spi_readblock: Read a block of data from a device
//-----------------------------------------------------------------
void spi_readblock(uint8_t *ptr, int length)
{
    int i;

    for (i=0;i<length;i++)
        *ptr++ = spi_sendrecv(0xFF);
}
//-----------------------------------------------------------------
// spi_writeblock: Write a block of data to a device
//-----------------------------------------------------------------
void spi_writeblock(uint8_t *ptr, int length)
{
    int i;

    for (i=0;i<length;i++)
        spi_sendrecv(*ptr++);
}
//-----------------------------------------------------------------
// Defines
//-----------------------------------------------------------------
#define CMD0_GO_IDLE_STATE              0
#define CMD1_SEND_OP_COND               1
#define CMD8_SEND_IF_COND               8
#define CMD17_READ_SINGLE_BLOCK         17
#define CMD24_WRITE_SINGLE_BLOCK        24
#define CMD32_ERASE_WR_BLK_START        32
#define CMD33_ERASE_WR_BLK_END          33
#define CMD38_ERASE                     38
#define ACMD41_SD_SEND_OP_COND          41
#define CMD55_APP_CMD                   55
#define CMD58_READ_OCR                  58

#define CMD_START_BITS                  0x40
#define CMD0_CRC                        0x95
#define CMD8_CRC                        0x87

#define OCR_SHDC_FLAG                   0x40
#define CMD_OK                          0x01

#define CMD8_3V3_MODE_ARG               0x1AA

#define ACMD41_HOST_SUPPORTS_SDHC       0x40000000

#define CMD_START_OF_BLOCK              0xFE
#define CMD_DATA_ACCEPTED               0x05

//-----------------------------------------------------------------
// Locals
//-----------------------------------------------------------------
static int _sdhc_card = 0;

//-----------------------------------------------------------------
// _sd_send_command: Send a command to the SD card over SPI
//-----------------------------------------------------------------
static uint8_t _sd_send_command(uint8_t cmd, uint32_t arg)
{
    uint8_t response = 0xFF;
    uint8_t status;
    t_time tStart;

    // If non-SDHC card, use byte addressing rather than block (512) addressing
    if(_sdhc_card == 0)
    {
        switch (cmd)
        {
            case CMD17_READ_SINGLE_BLOCK:
            case CMD24_WRITE_SINGLE_BLOCK:
            case CMD32_ERASE_WR_BLK_START:
            case CMD33_ERASE_WR_BLK_END:
                 arg *= 512;
                 break;
        }
    }

    // Send command
    spi_sendrecv(cmd | CMD_START_BITS);
    spi_sendrecv((arg >> 24));
    spi_sendrecv((arg >> 16));
    spi_sendrecv((arg >> 8));
    spi_sendrecv((arg >> 0));

    // CRC required for CMD8 (0x87) & CMD0 (0x95) - default to CMD0
    if(cmd == CMD8_SEND_IF_COND)
        spi_sendrecv(CMD8_CRC);
    else
        spi_sendrecv(CMD0_CRC);

    tStart = timer_now();

    // Wait for response (i.e MISO not held high)
    while((response = spi_sendrecv(0xFF)) == 0xff)
    {
       // Timeout
       if (timer_diff(timer_now(), tStart) >= 500)
           break;
    }

    // CMD58 has a R3 response
    if(cmd == CMD58_READ_OCR && response == 0x00)
    {
        // Check for SDHC card
        status = spi_sendrecv(0xFF);
        if(status & OCR_SHDC_FLAG) 
            _sdhc_card = 1;
        else 
            _sdhc_card = 0;

        // Ignore other response bytes for now
        spi_sendrecv(0xFF);
        spi_sendrecv(0xFF);
        spi_sendrecv(0xFF);
    }

    // Additional 8 clock cycles over SPI
    spi_sendrecv(0xFF);

    return response;
}
//-----------------------------------------------------------------
// _sd_init: Initialize the SD/SDHC card in SPI mode
//-----------------------------------------------------------------
static int _sd_init(void)
{   
    uint8_t response;
    uint8_t sd_version;
    int retries = 0;
    int i;

    // Initial delay to allow card to power-up
    timer_sleep(100);

    spi_cs(1);

    // Send 80 SPI clock pulses before performing init
    for(i=0;i<10;i++)
        spi_sendrecv(0xff);

    spi_cs(0);

    // Reset to idle state (CMD0)
    retries = 0;
    do
    {
        response = _sd_send_command(CMD0_GO_IDLE_STATE, 0);
        if(retries++ > 8)
        {
            spi_cs(1);
            return -1;
        }
    } 
    while(response != CMD_OK);

    spi_sendrecv(0xff);
    spi_sendrecv(0xff);

    // Set to default to compliance with SD spec 2.x
    sd_version = 2; 

    // Send CMD8 to check for SD Ver2.00 or later card
    retries = 0;
    do
    {
        // Request 3.3V (with check pattern)
        response = _sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
        if(retries++ > 8)
        {
            // No response then assume card is V1.x spec compatible
            sd_version = 1;
            break;
        }
    }
    while(response != CMD_OK);

    retries = 0;
    do
    {
        // Send CMD55 (APP_CMD) to allow ACMD to be sent
        response = _sd_send_command(CMD55_APP_CMD,0);

        timer_sleep(100);

        // Inform attached card that SDHC support is enabled
        response = _sd_send_command(ACMD41_SD_SEND_OP_COND, ACMD41_HOST_SUPPORTS_SDHC);

        if(retries++ > 8)
        {
            spi_cs(1);
            return -2;
        }
    }
    while(response != 0x00);

    // Query card to see if it supports SDHC mode   
    if (sd_version == 2)
    {
        retries = 0;
        do
        {
            response = _sd_send_command(CMD58_READ_OCR, 0);
            if(retries++ > 8)
                break;
        }
        while(response != 0x00);
    }
    // Standard density only
    else
        _sdhc_card = 0;

    return 0;
}
//-----------------------------------------------------------------
// sd_init: Initialize the SD/SDHC card in SPI mode
//-----------------------------------------------------------------
int sd_init(void)
{
    int retries = 0;

    // Peform SD init
    while (retries++ < 3)
    {
        if (_sd_init() == 0)
            return 0;

        timer_sleep(500);
    }

    return -1;
}
//-----------------------------------------------------------------
// sd_readsector: Read a number of blocks from SD card
//-----------------------------------------------------------------
int sd_readsector(uint32_t start_block, uint8_t *buffer, uint32_t sector_count)
{
    uint8_t response;
    uint32_t ctrl;
    t_time tStart;
    int i;

    if (sector_count == 0)
        return 0;

    while (sector_count--)
    {
        // Request block read
        response = _sd_send_command(CMD17_READ_SINGLE_BLOCK, start_block++);
        if(response != 0x00)
        {
            printf("sd_readsector: Bad response %x\n", response);
            return 0;
        }

        tStart = timer_now();

        // Wait for start of block indicator
        while(spi_sendrecv(0xFF) != CMD_START_OF_BLOCK)
        {
            // Timeout
            if (timer_diff(timer_now(), tStart) >= 1000)
            {
                printf("sd_readsector: Timeout waiting for data ready\n");
                return 0;
            }
        }

        // Perform block read (512 bytes)
        spi_readblock(buffer, 512);

        buffer += 512;

        // Ignore 16-bit CRC
        spi_sendrecv(0xFF);
        spi_sendrecv(0xFF);

        // Additional 8 SPI clocks
        spi_sendrecv(0xFF);
    }

    return 1;
}
//-----------------------------------------------------------------
// sd_writesector: Write a number of blocks to SD card
//-----------------------------------------------------------------
int sd_writesector(uint32_t start_block, uint8_t *buffer, uint32_t sector_count)
{
    uint8_t response;
    t_time tStart;
    int i;

    while (sector_count--)
    {
        // Request block write
        response = _sd_send_command(CMD24_WRITE_SINGLE_BLOCK, start_block++);
        if(response != 0x00)
        {
            printf("sd_writesector: Bad response %x\n", response);
            return 0;
        }

        // Indicate start of data transfer
        spi_sendrecv(CMD_START_OF_BLOCK);

        // Send data block
        spi_writeblock(buffer, 512);
        buffer += 512;

        // Send CRC (ignored)
        spi_sendrecv(0xff);
        spi_sendrecv(0xff);

        // Get response
        response = spi_sendrecv(0xFF);

        if((response & 0x1f) != CMD_DATA_ACCEPTED)
        {
            printf("sd_writesector: Data rejected %x\n", response);
            return 0;
        }

        tStart = timer_now();

        // Wait for data write complete
        while(spi_sendrecv(0xFF) == 0)
        {
            // Timeout
            if (timer_diff(timer_now(), tStart) >= 1000)
            {
                printf("sd_writesector: Timeout waiting for data write complete\n");
                return 0;
            }
        }

        // Additional 8 SPI clocks
        spi_sendrecv(0xff);

        tStart = timer_now();

        // Wait for data write complete
        while(spi_sendrecv(0xFF) == 0)
        {
            // Timeout
            if (timer_diff(timer_now(), tStart) >= 1000)
            {
                printf("sd_writesector: Timeout waiting for return to idle\n");
                return 0;
            }
        }
    }

    return 1;
}
//-----------------------------------------------------------------
// main
//-----------------------------------------------------------------
int main(int argc, char *argv[])
{
    // Initialise SPI interface
    spi_init_();

    // Initialise SD interface
    if (sd_init() < 0)
    {
        printf("ERROR: Cannot init SD card\n");
        return -1;
    }

    // Initialise File IO Library
    fl_init();

    // Attach media access functions to library
    if (fl_attach_media(sd_readsector, sd_writesector) != FAT_INIT_OK)
    {
        printf("ERROR: Failed to init file system\n");
        return -1;
    }
      fl_listdirectory("/");
      FL_FILE  *file;

      char rbuf[255];
      file = fl_fopen("/kianv.v", "r");

      while (fl_fread(rbuf, 1, 255, file) != EOF) {
        printf("%s\n", rbuf);
        memset(rbuf, 0, 255);
      }
      fl_fclose(file);

    /*
    // List the root directory
    char file_name[] = "/kianv.txt";
    for (;;) {
      fl_listdirectory("/kianvRiscV/simple");
      fl_listdirectory("/");

      FL_FILE  *file;

      file = fl_fopen(file_name, "w");
      uint8 buf[] = "This is a kian test\n";

      fl_fwrite(buf, 1, sizeof(buf), file);
      fl_fclose(file);
      fl_listdirectory("/");

      char rbuf[255];
      file = fl_fopen(file_name, "r");
      fl_fread(rbuf, 1, 255, file);
      printf("%s\n", rbuf);
      fl_fclose(file);

      fl_remove(file_name);
      fl_listdirectory("/");
      sleep(3);
    }
    */

    for (;;);

    return 0;
}

