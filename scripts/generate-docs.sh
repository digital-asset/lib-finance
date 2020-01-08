cd ..
daml damlc docs -o "docs/Reference.md" -f "md" "daml/LibraryModules.daml" --combine --exclude-instances "HasField,Eq,Show"
