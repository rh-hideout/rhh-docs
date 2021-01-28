meta:
  id: oam
  file-extension: oam
  endian: le
  title: "Gen V OAM structure"
  application: "Pokémon Black and White, Pokémon Black 2 and White 2"
seq:
  - id: header
    type: oam_header
  - id: oams
    type: oam_entry
    repeat: expr
    repeat-expr: header.n_cells * 2
types:
  oam_header:
    seq:
      - id: n_cells
        type: u4
      - id: x_max # Unused?
        type: u2
      - id: y_max # Unused?
        type: u2
      - id: x_min # Unused?
        type: u2
      - id: y_min # Unused?
        type: u2
      - id: unk # Unused?
        type: u1
  oam_entry:
    seq:
      - id: x
        type: s4
      - id: y
        type: s4
      - id: size_x
        type: s4
      - id: size_y
        type: s4
      - id: cell_x
        type: s4
      - id: cell_y
        type: s4
