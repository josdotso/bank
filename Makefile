SHELL := bash

.PHONY: deps
deps:  ## Install dependencies.
	@echo "==> Installing dependencies."
	npm install -g api-spec-converter
	go get -u github.com/NYTimes/openapi2proto/cmd/openapi2proto

.PHONY: gen
gen:  ## Generate artifacts.
gen: generated/openapi3.yaml
gen: generated/v3.proto
gen: generated/schema.sql
	@echo "==> Generating artifacts."

generated/openapi3.yaml:  ## Generate OpenAPI v3 specification.
	@echo "==> Generating OpenAPI v3 specification."
	mkdir -p generated
	api-spec-converter --from=swagger_2 --to=openapi_3 --syntax=yaml --order=alpha \
		backend/src/utils/swagger/swagger.json \
	| dos2unix \
	| tee $@

generated/v3.proto:  ## Generate Protocol Buffers v3 specification.
	@echo "==> Generating Protocol Buffers v3 specification."
	mkdir -p generated
	openapi2proto -spec generated/openapi3.yaml -annotate \
	| dos2unix \
	| tee $@

generated/schema.sql:  ## Generate MySQL schema.
	@echo "==> Generating MySQL schema."
	mkdir -p generated
	source backend/.env \
		&& pushd backend \
		&& docker-compose exec db /bin/bash -c "MYSQL_PWD=$${DB_PASSWORD} mysqldump \
		     -u$${DB_USERNAME} \
                     --protocol=tcp -h$${DB_HOST} -P$${DB_PORT} \
                     --no-data $${DB_NAME}" \
		| dos2unix \
		| grep -v '^-- Dump completed' \
		| tee ../generated/schema.sql
