meta:
  id: fsys
  file-extension: FSYS
  endian: be
seq:
  - id: header
    type: header
    size: 0x40
  - id: file_table
    type: file_table
    size: 0x20
  - id: file_entries
    type: file_entries
    repeat: expr
    repeat-expr: header.file_count

types:
  header:
    seq:
      - id: magic
        size: 4
        #0.0.2.1 for XD
      - id: version
        size: 4
      - id: file_index
        type: u4
      - id: file_count
        type: u4
      - id: reloc_pointer
        type: u4
        #Reserved_2 seems to be always 3
      - id: reserved_2
        type: u4
      - id: header_size
        type: u4
      - id: data_pos
        type: u4
      - id: filesize
        type: u4

  file_table:
    seq:
      - id: entry_pos
        type: u4
      - id: name_table_pos
        type: u4
      - id: data_pos
        type: u4

  file_entries:
    seq:
      - id: entry_pos
        type: u4
    instances:
      entry:
        pos: entry_pos
        type: file_entry
        size: 0x70

  file_entry:
    seq:
      - id: file_hash
        type: u4
      - id: data_pos
        type: u4
      - id: uncompressed_size
        type: u4
      - id: reloc_pos
        type: u4
      - id: reserved_1
        type: u4
      - id: compressed_size
        type: u4
      - id: reserved_2
        type: u4
      - id: fname_pos
        type: u4
      - id: file_type
        type: u4
        enum: filetypes
      - id: name_pos
        type: u4
    instances:
      data:
        io: _root._io
        pos: data_pos
        size: compressed_size

enums:
  filetypes:
    0x0: a_file
    0x1: dat_file
    0x2: dat_file
    0x3: ccd_file
    0x4: bin_file
    0x5: msg_file
    0x6: fnt_file
    0x7: scd_file
    0x9: gtx_file
    0xA: gpt_file
    0xB: bin_file
    0xC: cdat_file
    0xD: bin_file
    0xE: rel_file
    0xF: f3d_file
    0x10: wzx_file
    0x11: bin_file
    0x12: bin_file
    0x14: ish_file
    0x15: isd_file
    0x16: thh_file
    0x17: thd_file
    0x18: gsw_file
    0x1A: bin_file
    
    
  
