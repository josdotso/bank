SHELL := bash

.PHONY: gen
gen:  ## Generate artifacts.
gen: generated/schema.sql
	@echo "==> Generating artifacts."
	mkdir -p ./generated

generated/schema.sql:
	@echo "==> Generating MySQL schema."
	source backend/.env \
		&& pushd backend \
		&& docker-compose exec db mysqldump \
		     -u$${DB_USERNAME} -p$${DB_PASSWORD} \
                     --protocol=tcp -h$${DB_HOST} -P$${DB_PORT} \
                     --no-data $${DB_NAME} \
		| tee ../generated/schema.sql
