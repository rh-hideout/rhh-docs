meta:
  id: bseq
  file-extension: bseq
  endian: le
seq:
  - id: header
    type: header
  - id: keyframes
    type: keyframe
    repeat: expr
    repeat-expr: header.num_keyframes
  - id: noclue
    size: header.num_reserved
  - id: something
    type: something
    repeat: expr
    repeat-expr: header.num_reserved2
types:
  header:
    seq:
      - id: magic
        contents: "SESD"
        #3 For LGPE, 4 for SWSH
      - id: version
        type: u4
        #Always 0
      - id: reserved
        type: u4
        #This one is 0 in tu002, which conveniently
        #Ends after the keyframes
      - id: num_reserved2
        type: u4
        # Am thinking this one might be related to
        # Alignment since it's typically 0x4 or 0x20
      - id: num_reserved
        type: u4
      - id: num_keyframes
        type: u4
  keyframe:
    seq:
      - id: reserved1
        type: u4
      - id: reserved2
        type: u4
      - id: len_reserved
        type: u4
  something:
    seq:
    - id: reserved1
      type: u4
      repeat: expr
      repeat-expr: 0


