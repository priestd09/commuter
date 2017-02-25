# Builds and installs the commuter CLI.
install:
	@go install github.com/KyleBanks/commuter 
.PHONY: install

# Runs an example commuter request for travel duration.
example: | install
	@commuter -to "Toronto, Canada"
.PHONY: example

# Runs test suit, vet, golint, and fmt.
sanity:
	@echo "---------------- TEST ----------------"
	@go list ./... | grep -v vendor/ | xargs go test --cover 

	@echo "---------------- VET ----------------"
	@go list ./... | grep -v vendor/ | xargs go vet 

	@echo "---------------- LINT ----------------"
	@go list ./... | grep -v vendor/ | xargs golint

	@echo "---------------- FMT ----------------"
	@go list ./... | grep -v vendor/ | xargs go fmt
.PHONY: sanity

# Creates release binaries for each supported platform/architecture.
release: | sanity
	@gox -osarch="darwin/386 darwin/amd64 linux/386 linux/amd64 linux/arm windows/386 windows/amd64" \
		-output "bin/{{.Dir}}_{{.OS}}_{{.Arch}}" .
.PHONY: release