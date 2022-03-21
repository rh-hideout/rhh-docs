##These files have so much free space for reasons....
##In this case, it has extra space so repointed (relocated) data
##can get tracked in memory once relocated

##0x98761234 == shader reflection (text)
##0x12345678 == shader binary

meta:
  id: bnsh
  file-extension: bnsh
  endian: le
seq:
  - id: header
    type: header
    size: 0x60
  - id: blocks
    type: block_header
    size: header.ptr_rlt - header.ptr_root
  - id: rlt
    type: relocation_table
    size-eos: true

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
      - id: reserved
        size: 0x40
    instances:
      shader_name:
        io: _root._io
        pos: ptr_name
        type: str
        terminator: 0x00
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
        if: ofs_next != 0x0
        pos: ofs_next
        type: block_header
  grsc_block:
    seq:
    - id: code_type
      type: u1
    - id: reserved2
      size: 3
    - id: target_api_type
      type: u2
    - id: target_api_version
      type: u2
    - id: compiler_version
      type: u4
    - id: num_shaders
      type: u4
    - id: ofs_shader
      type: u8
    - id: ofs_prog
      type: u8
    - id: llc_version
      type: u8
    - id: reserved
      size: 40
    - id: shader_variation_array
      type: shader_variation_data
      repeat: expr
      repeat-expr: num_shaders

    instances:

      shader_binary_pool:
        io: _root._io
        pos: ofs_prog
        type: prog_resource

    types:
      shader_variation_data:
        seq:
          - id: ofs_source_data
            type: u8
          - id: ofs_il_data
            type: u8
          - id: ofs_bin_data
            type: u8
          - id: ofs_parent
            type: u8
          - id: reserved
            size: 0x20
        instances:
          source_data:
            if: ofs_source_data != 0
            io: _root._io
            pos: ofs_source_data
            type: shader_data
          il_data:
            if: ofs_il_data != 0
            io: _root._io
            pos: ofs_il_data
            type: shader_data
          binary_data:
            if: ofs_bin_data != 0
            io: _root._io
            pos: ofs_bin_data
            type: shader_data

      shader_data:
        seq:
          - id: info
            type: shader_info
          - id: ofs_obj
            type: u8
          - id: obj_size
            type: u4
          - id: reserved2
            size: 4
          - id: ofs_parent
            type: u8
          - id: ofs_shader_reflection
            type: u8
          - id: ofs_compiler_reflection
            type: u8
          - id: reserved
            size: 24
        instances:
          shader_reflection:
            if: ofs_shader_reflection != 0
            pos: ofs_shader_reflection
            type: shader_reflection_data
          compiler_reflection:
            if: ofs_compiler_reflection != 0
            pos: ofs_compiler_reflection
            type: u4

      shader_info:
        seq:
          - id: bin_format
            type: u4
          - id: code_type
            type: u1
          - id: source_type
            type: u1
          - id: flags
            type: b8
          - id: reserved2
            size: 1
          - id: ofs_vertex
            type: u8
          - id: ofs_domain
            type: u8
          - id: ofs_geo
            type: u8
          - id: ofs_hull
            type: u8
          - id: ofs_pixel
            type: u8
          - id: ofs_compute
            type: u8
          - id: reserved
            size: 40
        instances:
          vertex_shader:
            if: ofs_vertex != 0
            pos: ofs_vertex
            type: shader_entry
          pixel_shader:
            if: ofs_pixel != 0
            pos: ofs_pixel
            type: shader_entry
 
      shader_reflection_data:
        seq:
          - id: ofs_vertex
            type: u8
          - id: ofs_domain
            type: u8
          - id: ofs_geo
            type: u8
          - id: ofs_hull
            type: u8
          - id: ofs_pixel
            type: u8
          - id: ofs_compute
            type: u8
          - id: reserved
            size: 16

        instances:
          vertex_stage_data:
            if: ofs_vertex != 0
            pos: ofs_vertex
            type: shader_stage_data

          pixel_stage_data:
            if: ofs_pixel !=0
            pos: ofs_pixel
            type: shader_stage_data

      shader_stage_data:
        seq:
        - id: ofs_input_dict
          type: u8
        - id: ofs_output_dict
          type: u8
        - id: ofs_sampler_dict
          type: u8
        - id: ofs_constant_dict
          type: u8
        - id: work_z
          type: u4
        - id: work_y
          type: s4
        - id: start_output
          type: s4
        - id: start_sampler
          type: s4
        - id: start_constant
          type: s4
        - id: start_unordered
          type: s4
        - id: ofs_slot_array
          type: u8
        - id: ofs_image_dict
          type: u8
        - id: work_x
          type: u4
        - id: start_image
          type: u4
        - id: ofs_unordered_dict
          type: u8
        - id: ofs_reflection_data
          type: u8

        instances:
          input_dict:
            if: ofs_input_dict != 0
            pos: ofs_input_dict
            type: dictionary_table
          output_dict:
            if: ofs_output_dict != 0
            pos: ofs_output_dict
            type: dictionary_table
          sampler_dict:
            if: ofs_sampler_dict != 0
            pos: ofs_sampler_dict
            type: dictionary_table
          constant_buffer_dict:
            if: ofs_constant_dict != 0
            pos: ofs_constant_dict
            type: dictionary_table
          image_buffer_dict:
            if: ofs_image_dict != 0
            pos: ofs_image_dict
            type: dictionary_table              
          unordered_access_dict:
            if: ofs_unordered_dict != 0
            pos: ofs_unordered_dict
            type: dictionary_table
          reflection_data:
            if: ofs_reflection_data !=0
            pos: ofs_reflection_data
            size: 2
          slot_array:
            pos: ofs_slot_array
            size: 4 * start_unordered

#OLD
      shader_entry:
        seq:
          - id: unk
            type: u8
          - id: ofs_shader_reflection
            type: u8
          - id: ofs_shader_prog
            type: u8
          - id: len_shader_prog
            type: u4
          - id: len_shader_reflection
            type: u4
          - id: reserved
            size: 0x20
        instances:
          # Types are commented out so I can just dump blobs
          # Mostly to test shader swapping....
          shader_reflection: 
            pos: ofs_shader_reflection
            size: len_shader_reflection
            # type: reflection_file
          shader_prog: 
            pos: ofs_shader_prog
            size: len_shader_prog
            # type: prog_file

      reflection_file:
        seq:
          - id: header
            type: reflection_file_header
            size: 0x6F0
          - id: unk1
            type: reflection_file_sec1
            size: 0x88
          - id: unk2
            type: reflection_file_sec2
            size: 0x50
          - id: unk3
            type: u8

      reflection_file_header:
        seq:
          - id: magic
            contents: [0x34, 0x12, 0x76, 0x98]
  
      reflection_file_sec1:
        seq:
          - id: unk0
            type: u4
          - id: unk1
            type: u4

      reflection_file_sec2:
        seq:
          - id: unk0
            type: u4
          - id: unk1
            type: u4

      prog_file:
        seq:
          - id: magic
            contents: [0x78, 0x56, 0x32, 0x12]

      prog_resource:
        seq:
          - id: prog_type
            type: u4
          - id: len_prog
            type: u4
          - id: ofs_prog
            type: u8
          - id: ofs_reloc_prog
            type: u8
        instances:
          #Note, not useful, better to go through shader entries
          prog_block:
            pos: ofs_prog
            size: len_prog
              
  string_block:
    seq:
      - id: count
        type: u8
      - id: strings
        type: string_entry
        repeat: expr
        repeat-expr: count
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
        repeat: expr
        repeat-expr: count + 1
  dictionary_node:
    seq:
      - id: index
        type: s4
      - id: left_idx
        type: u2
      - id: right_idx
        type: u2
      - id: payload
        type: u8
    instances:
      name:
        pos: payload
        type: string_entry
  
  relocation_table:
    seq:
      - id: magic
        contents: '_RLT'
      - id: pos_rlt
        type: u4
      - id: count_section
        type: u4
      - id: padding
        size: 0x4
      - id: sections
        type: relocation_section
        repeat: expr
        repeat-expr: count_section

    types:
      relocation_section:
        seq:
          - id: reloc_pos
            type: u4
          - id: reloc_size
            type: u4
          - id: pos
            type: u4
          - id: size
            type: u4
          - id: entry_start
            type: u4
          - id: entry_count
            type: u4

        instances:
          reloc_section:
            io: _root._io
            pos: pos
            size: size

          relocation_entries:
            type: relocation_entry
            io: _parent._io
            pos: _parent._io.pos + entry_start * 0x8
            repeat: expr
            repeat-expr: entry_count

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
        instances:
          peek:
            io: _root._io
            pos: position
            size: 1

