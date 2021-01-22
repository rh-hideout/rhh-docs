meta:
  id: bntx
  file-extension: bntx
  endian: le
seq:
  - id: header
    type: header
  - id: nx_header
    type: nx_header
instances:
  blocks:
    pos: header.ptr_root
    type: block_header
  rlt:
    pos: header.ptr_rlt
    type: relocation_table

types:
  header:
    seq:
      - id: magic
        size: 8
      - id: version
        size: 4
      - id: byte_order
        type: u2
      - id: align
        type: u1
      - id: size_align
        type: u1
      - id: ptr_name
        type: u4
      - id: bool_reloc
        type: u2
      - id: ptr_root
        type: u2
      - id: ptr_rlt
        type: u4
      - id: size_file
        type: u4
  block_header:
    seq:
      - id: magic
        type: str
        encoding: ASCII
        size: 4
      - id: ofs_next
        type: u4
      - id: len_block
        type: u4
      - id: reserved
        type: u4
      - id: block
        type:
          switch-on: magic
          cases:
            "'BRTI'": brti_header
            "'_STR'": string_block
            "'_RLT'": relocation_table
    instances:
      next_block:
        pos: ofs_next
        type: block_header
  
  nx_header:
    seq:
      - id: magic
        contents: 'NX'
      - id: inner_version
        size: 2
      - id: version
        size: 4
      - id: noclue
        type: u8
      - id: block
        size: noclue
  
  brti_header:
    seq:
      - id: unk
        size: 4

  string_block:
    seq:
      - id: count
        type: u8
      - id: strings
        type: string_entry
        repeat: expr
        repeat-expr: count
    types:
      string_entry:
        seq:
          - id: len_string
            type: u2
          - id: string
            type: str
            size: len_string
            encoding: UTF-8
          - id: alignment
            size: 1 + (_io.pos + 1) % 2

  relocation_table:
    seq:
      - id: magic
        contents: '_RLT'
      - id: pos_rlt
        type: u4
      - id: count_section
        type: u4
      - id: sections
        type: relocation_section
    types:
      relocation_section:
        seq:
          - id: pos
            type: u4
          - id: size
            type: u4
          - id: index
            type: u4
          - id: count
            type: u4
        instances:
          relocation_entries:
            type: relocation_entry
            pos: pos
            size: size
            repeat: expr
            repeat-expr: count
      relocation_entry:
        seq:
          - id: position
            type: u4
          - id: count_structure
            type: u2
          - id: count_offset
            type: u1
          - id: count_padding
            type: u1
