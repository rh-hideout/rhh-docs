meta:
  id: nvgpu5
  file-extension: nvgpu5
  endian: le
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
instances:
  shader:
    pos: header.shader_pos
    size: header.shader_len
types:
      reflection_file_header:
        seq:
          - id: magic
            contents: [0x34, 0x12, 0x76, 0x98]
          - id: unk_count
            type: u4
          - id: unk_2
            type: u4
          - id: unk_3
            type: u4
          - id: unk_4
            type: u4
          - id: shader_pos
            type: u4
          - id: shader_len
            type: u4
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
