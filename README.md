# Development

## Generating JSON deserialization code

This is necessary whenever `lib/json_data/types.dart` or `assets/CSRD.json` is changed.

```sh
dart run build_runner build
```

## Shout-outs

Thanks to Jon Davis for his hard work compiling the Cypher System SRD to [JSON format](https://github.com/Jon-Davis/Cypher-System-JSON-DB).