meta:
  id: gfpak
  file-extension: gfpak
  endian: le
seq:
  - id: header
    type: header
  - id: ofs_files
    type: u8
  - id: ofs_file_hashes
    type: u8
  - id: ofs_folder_hashes
    type: u8
    repeat: expr
    repeat-expr: header.num_folders

instances:
  filehashes:
    pos: ofs_file_hashes
    type: u8
    repeat: expr
    repeat-expr: header.num_files
  folderhashes:
    pos: ofs_folder_hashes[0]
    type: folderhash
    repeat: expr
    repeat-expr: header.num_folders
  files:
    pos: ofs_files
    type: fileinfo
    repeat: expr
    repeat-expr: header.num_files
enums:
  compression:
    0: none
    1: zlib
    2: lz4
types:
    header:
      seq:
        - id: magic
          contents: 'GFLXPACK'
        - id: version
          size: 4
        - id: bool_reloc
          type: u4
        - id: num_files
          type: u4
        - id: num_folders
          type: u4
    fileinfo:
      seq:
        - id: level
          type: u2
        - id: type_compression
          type: u2
          enum: compression
        - id: len_decompressed
          type: u4
        - id: len_compressed
          type: u4
        - id: reserved_1
          type: u4
        - id: ofs_file
          type: u4
        - id: reserved_2
          type: u4
      instances:
        file:
          pos: ofs_file
          size: len_compressed
    folderhash:
      seq:
        - id: hash
          type: u8
        - id: num_subfiles
          type: u4
        - id: reserved
          type: u4
        - id: subfile
          type: filehash
          repeat: expr
          repeat-expr: num_subfiles
  
    filehash:
      seq:
        - id: hash
          type: u8
        - id: index
          type: u4
        - id: reserved
          type: u4

