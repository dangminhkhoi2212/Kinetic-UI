# TODO
- [ ] Update CLI to support `kinetic add --all`
  - [ ] Add `--all` flag parsing in `cli/bin/kinetic.dart`
  - [ ] Implement `runAll()` in `cli/lib/commands/add.dart` using `registry.fetchIndex()` to get all component names
  - [x] Ensure `--force` works with `--all`
  - [x] (Optional) Run tests / basic smoke run


