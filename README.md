# rmp-serde-kotlin in Kotlin

[![GitHub link](https://img.shields.io/badge/GitHub-KotlinMania%2Frmp-serde-kotlin-blue.svg)](https://github.com/KotlinMania/rmp-serde-kotlin)
[![Maven Central](https://img.shields.io/maven-central/v/io.github.kotlinmania/rmp-serde-kotlin)](https://central.sonatype.com/artifact/io.github.kotlinmania/rmp-serde-kotlin)
[![Build status](https://img.shields.io/github/actions/workflow/status/KotlinMania/rmp-serde-kotlin/ci.yml?branch=main)](https://github.com/KotlinMania/rmp-serde-kotlin/actions)

This is a Kotlin Multiplatform line-by-line transliteration port of [`3Hren/msgpack-rust`](https://github.com/3Hren/msgpack-rust) (crate `rmp-serde`).

**Original Project:** This port is based on [`3Hren/msgpack-rust`](https://github.com/3Hren/msgpack-rust). All design credit and project intent belong to the upstream authors; this repository is a faithful port to Kotlin Multiplatform with no behavioural changes intended.

### Porting status

This is an **in-progress port**. The goal is feature parity with the upstream Rust crate while providing a native Kotlin Multiplatform API. Every Kotlin file carries a `// port-lint: source <path>` header naming its upstream Rust counterpart so the AST-distance tool can track provenance.

---

## Upstream README — `3Hren/msgpack-rust`

> The text below is reproduced from [`https://github.com/3Hren/msgpack-rust`](https://github.com/3Hren/msgpack-rust). It is the upstream project's own description and remains under the upstream authors' authorship; links have been rewritten to absolute upstream URLs where appropriate so they continue to resolve from this repository.

# MessagePack + Serde

This crate connects Rust MessagePack library with [`serde`][serde] providing an ability to
easily serialize and deserialize both Rust built-in types, the standard library and custom data
structures.

## Motivating example

```rust
let buf = rmp_serde::to_vec(&(42, "the Answer")).unwrap();

assert_eq!(
    vec![0x92, 0x2a, 0xaa, 0x74, 0x68, 0x65, 0x20, 0x41, 0x6e, 0x73, 0x77, 0x65, 0x72],
    buf
);

assert_eq!((42, "the Answer"), rmp_serde::from_slice(&buf).unwrap());
```

## Type-based Serialization and Deserialization

Serde provides a mechanism for low boilerplate serialization & deserialization of values to and
from MessagePack via the serialization API.

To be able to serialize a piece of data, it must implement the `serde::Serialize` trait. To be
able to deserialize a piece of data, it must implement the `serde::Deserialize` trait. Serde
provides an annotation to automatically generate the code for these
traits: `#[derive(Serialize, Deserialize)]`.

## Examples

```rust
use std::collections::HashMap;
use serde::{Deserialize, Serialize};
use rmp_serde::{Deserializer, Serializer};

#[derive(Debug, PartialEq, Deserialize, Serialize)]
struct Human {
    age: u32,
    name: String,
}

fn main() {
    let mut buf = Vec::new();
    let val = Human {
        age: 42,
        name: "John".into(),
    };

    val.serialize(&mut Serializer::new(&mut buf)).unwrap();
}
```

## Efficient storage of `&[u8]` types

MessagePack can efficiently store binary data. However, Serde's standard derived implementations *do not* use binary representations by default. Serde prefers to represent types like `&[u8; N]` or `Vec<u8>` as arrays of objects of arbitrary/unknown type, and not as slices of bytes. This creates about a 50% overhead in storage size.

Wrap your data in [`serde_bytes`](https://lib.rs/crates/serde_bytes) to store blobs quickly and efficiently. Alternatively, [configure an override in `rmp_serde` to force use of byte slices](https://docs.rs/rmp-serde/latest/rmp_serde/encode/struct.Serializer.html#method.with_bytes).

[serde]: https://serde.rs/

---

## About this Kotlin port

### Installation

```kotlin
dependencies {
    implementation("io.github.kotlinmania:rmp-serde-kotlin:0.1.0")
}
```

### Building

```bash
./gradlew build
./gradlew test
```

### Targets

- macOS arm64
- Linux x64
- Windows mingw-x64
- iOS arm64 / simulator-arm64 (Swift export + XCFramework)
- JS (browser + Node.js)
- Wasm-JS (browser + Node.js)
- Android (API 24+)

### Porting guidelines

See [AGENTS.md](AGENTS.md) and [CLAUDE.md](CLAUDE.md) for translator discipline, port-lint header convention, and Rust → Kotlin idiom mapping.

### License

This Kotlin port is distributed under the same license terms as the upstream [`3Hren/msgpack-rust`](https://github.com/3Hren/msgpack-rust). See [LICENSE](LICENSE) (and any sibling `LICENSE-*` / `NOTICE` files mirrored from upstream) for the full text.

Original work copyrighted by the rmp-serde authors.  
Kotlin port: Copyright (c) 2026 Sydney Renee and The Solace Project.

### Acknowledgments

Thanks to the [`3Hren/msgpack-rust`](https://github.com/3Hren/msgpack-rust) maintainers and contributors for the original Rust implementation. This port reproduces their work in Kotlin Multiplatform; bug reports about upstream design or behavior should go to the upstream repository.
