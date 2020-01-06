SHELL := bash

.PHONY: deps
deps:  ## Install dependencies.
	@echo "==> Installing dependencies."
	npm install -g api-spec-converter

.PHONY: gen
gen:  ## Generate artifacts.
gen: generated/openapi-v3.yaml
gen: generated/schema.sql
	@echo "==> Generating artifacts."

generated/openapi-v3.yaml:
	mkdir -p generated
	api-spec-converter --from=swagger_2 --to=openapi_3 --syntax=yaml --order=alpha \
		backend/src/utils/swagger/swagger.json \
	| tee $@

generated/schema.sql:  ## Generate MySQL schema.
	@echo "==> Generating MySQL schema."
	mkdir -p generated
	source backend/.env \
		&& pushd backend \
		&& docker-compose exec db mysqldump \
		     -u$${DB_USERNAME} -p$${DB_PASSWORD} \
                     --protocol=tcp -h$${DB_HOST} -P$${DB_PORT} \
                     --no-data $${DB_NAME} \
		| tee ../generated/schema.sql
