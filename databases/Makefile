DB=praestitia_test
PSQL=psql -U $(USER) -d $(DB)

.PHONY: all setup seed test clean reset

all: setup seed test

setup:
	psql -U $(USER) -c "DROP DATABASE IF EXISTS $(DB);"
	psql -U $(USER) -c "CREATE DATABASE $(DB);"
	$(PSQL) -f modelo_fisico.sql

seed:
	$(PSQL) -f seed.sql

test:
	$(PSQL) -f consultas.sql

clean:
	psql -U $(USER) -c "DROP DATABASE IF EXISTS $(DB);"

reset: clean setup seed
