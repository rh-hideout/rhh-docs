# Kaitai does not currently provide the processing libs needed
# by default
# Please implement them on your own parser
# by following the code sample in Kaitai's User Docs

meta:
  id: unity3d
  file-extension: unity3d
  endian: be
  encoding: UTF-8

seq:
  - id: header
    type: header
  - id: blocks
    if: header.flags.f_archive_combined
    size: header.compressed_block_len
    type: 
      switch-on: header.flags.f_compression_type
      cases:
        "compression_type::raw"  : archive_directory_blocks
        "compression_type::lzma" : lzma_archive_directory_blocks
        "compression_type::lz4"  : lz4_archive_directory_blocks
        "compression_type::lz4hc": lz4hc_archive_directory_blocks
        _: blob_archive_directory_blocks
  - id: directory_info
    type: directory_blocks
    if: header.flags.f_archive_separated
  #Suggested workflow is to use the above info to decompress
  #And split blob later, Kaitai itself is a bit useless
  #in this regard!
  - id: blob
    size-eos: true

instances:
  archive_info:
    if: header.flags.f_archive_separated
    pos: header.len_file - header.compressed_block_len
    size: header.compressed_block_len
    type: 
      switch-on: header.flags.f_compression_type
      cases:
        "compression_type::raw"  : archive_blocks
        "compression_type::lzma" : lzma_archive_blocks
        "compression_type::lz4"  : lz4_archive_blocks
        "compression_type::lz4hc": lz4hc_archive_blocks
        _: blob_archive_blocks

types:
  header:
    seq:
      - id: magic
        type: strz
      - id: version
        type: u4
      - id: unity_version
        type: strz
      - id: unity_revision
        type: strz
      - id: len_file
        type: u8
      - id: compressed_block_len
        type: u4
      - id: uncompressed_block_len
        type: u4
      - id: flags
        type: asset_flags
        size: 4
    types:
      asset_flags:
        seq:
          - id: hi_flags
            type: u2
          - id: mid_flags
            type: b8
          # In this case, Archive Blocks Info are at the end
          - id: f_archive_separated
            type: b1
          # In this case, Archive Blocks and Directory Info are Combined
          - id: f_archive_combined
            type: b1
          - id: f_compression_type
            type: b6
            enum: compression_type

  blob_archive_blocks:
    seq:
      - id: blob
        size-eos: true

  lzma_archive_blocks:
    seq:
      - id: blocks
        type: archive_blocks
        process: process_lzma(_root.header.uncompressed_block_len)
        size-eos: true

  lz4_archive_blocks:
    seq:
      - id: blocks
        type: archive_blocks
        process: process_lz4(_root.header.uncompressed_block_len)
        size-eos: true

  lz4hc_archive_blocks:
    seq:
      - id: blocks
        type: archive_blocks
        process: process_lz4hc(_root.header.uncompressed_block_len)
        size-eos: true
  
  blob_archive_directory_blocks:
    seq:
      - id: blob
        size-eos: true

  lzma_archive_directory_blocks:
    seq:
      - id: blocks
        type: archive_directory_blocks
        process: process_lzma(_root.header.uncompressed_block_len)
        size-eos: true

  lz4_archive_directory_blocks:
    seq:
      - id: blocks
        type: archive_directory_blocks
        process: process_lz4(_root.header.uncompressed_block_len)
        size-eos: true

  lz4hc_archive_directory_blocks:
    seq:
      - id: blocks
        type: archive_directory_blocks
        process: process_lz4hc(_root.header.uncompressed_block_len)
        size-eos: true

  archive_directory_blocks:
    seq:
      - id: block
        type: archive_blocks
      - id: directory
        type: directory_blocks

  archive_blocks:
    seq:
      - id: hash
        size: 16
      - id: archive_count
        type: u4
      - id: archives
        type: archive_block
        repeat: expr
        repeat-expr: archive_count
    types:
      archive_block:
        seq:
          - id: uncompressed_len
            type: u4
          - id: compressed_len
            type: u4
          - id: flags
            type: archive_flags
        # instances:
        #   blob:
        #     io: _root._io
        #     size: compressed_len
        #     process: process_lz4hc(uncompressed_len)

      archive_flags:
        seq:
          - id: flags_high
            type: b8
          - id: flags_mid
            type: b2
          - id: f_compression_type
            type: b6
            enum: compression_type

  directory_blocks:
    seq:
      - id: directory_count
        type: u4
      - id: directories
        type: directory_block
        repeat: expr
        repeat-expr: directory_count

    types:
      directory_block:
        seq:
          - id: directory_pos
            type: u8
          - id: directory_len
            type: u8
          - id: directory_flags
            type: directory_flags
          - id: path
            type: strz

      directory_flags:
        seq:
          - id: flags_high
            type: u2
          - id: flags_mid
            type: b8
          - id: flags_low
            type: b8
          
enums:
  compression_type:
    0: raw
    1: lzma
    2: lz4
    3: lz4hc
