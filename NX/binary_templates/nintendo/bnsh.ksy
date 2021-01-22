meta:
  id: bnsh
  file-extension: bnsh
  endian: le
seq:
  - id: header
    type: header
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
    instances:
      shader_name:
        pos: ptr_name
        type: str
        terminator: 0
        encoding: UTF-8
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
            '"grsc"': grsc_block
            "'_STR'": string_block
    instances:
      next_block:
        pos: ofs_next + 0x60
        type: block_header
  grsc_block:
    seq:
      - id: a_type
        type: u2
      - id: a_version
        type: u2
      - id: c_type
        type: u2
      - id: reserved
        type: u2
      - id: c_version
        size: 4
      - id: num_shaders
        type: u4
      - id: ofs_shader
        type: u8
      - id: ofs_p
        type: u8
      - id: llc_version
        size: 8
    instances:
      shader:
        pos: ofs_shader
        type: shader
        repeat: expr
        repeat-expr: num_shaders
      prog:
        pos: ofs_p
        size: 8
    types:
      shader:
        seq:
          - id: ofs_unknown0
            type: u8
          - id: ofs_unknown1
            type: u8
          - id: ofs_unknown2
            type: u8
          - id: ofs_parent
            type: u8
        instances:
          data:
            pos: ofs_unknown2
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

  dictionary_table:
    seq:
      - id: magic
        contents: '_DIC'
      - id: count
        type: u4
      - id: rootnode
        type: dictionary_node
    types:
      dictionary_node:
        seq:
          - id: index
            type: u4
          - id: ptr_left
            type: u2
          - id: ptr_right
            type: u2
          - id: payload
            type: u8
        instances:
          leftnode:
            type: dictionary_node
            pos: ptr_left
          rightnode:
            type: dictionary_node
            pos: ptr_right

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

