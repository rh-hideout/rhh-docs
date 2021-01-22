# Flatbuffers

Since gflib3, Game Freak has adopted the [`flatbuffers`](https://google.github.io/flatbuffers/) library for serializing their files.

### Deserializing

In order to de-serialize, you can use one of the .fbs files provided in this repo and [Google's flatc tool](https://github.com/google/flatbuffers/releases/tag/v1.12.0).

### Reverse Engineering Flatbuffers

TODO: Explain this and provide a sample .ksy file for flatbuffer internals.

Most flatbuffers follow a similar structure....

Root PTR > Node > Vtable > Object info......

### Notes

It is important to know that the flatbuffer compiler Game Freak used is [`flatcc`](https://github.com/dvidelabs/flatcc) which serializes in different ways from flatc:

* VTable rel-pointers (relative pointers) tend to be negative by default.
* VTable rel-pointers can be shared.
* Strings can be shared.

Flatc takes the naïve approach and does not offer these optimizations, for modding purposes this is not an inconvenience.
