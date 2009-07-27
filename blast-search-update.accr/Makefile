SPLIT_NUM=80
SEQSPLIT=/usr/local/bin/seqsplit-fasta
DIR = $(shell pwd)

main: get-seqs get-db
	$(DIR)/scripts/rename-input-files
	$(DIR)/scripts/qsub-all


get-seqs:
	$(SEQSPLIT) -i \
	$(DIR)/ONE-FAMILY.fasta \
	-L $(SPLIT_NUM) -p 'input-'

get-db: concat-all-sources
	formatdb -i UNIPROT-AND-MORE.fasta
	rm UNIPROT-AND-MORE.fasta

concat-all-sources:
	cat $(DIR)/Sourcemap | \
        /usr/bin/awk '/^[a-zA-Z]/ {print $$1}' | \
        /bin/grep 'prot--$$' | \
        $(DIR)/scripts/concat-all-seqs | \
        /usr/bin/xargs /bin/cat > \
        UNIPROT-AND-MORE.fasta

clean:
	rm -f *.sh
	rm -f *-input
	rm -f *-hits 
	rm -f *.e*
	rm -f *.o*
	rm -f UNIPROT-AND-MORE.fasta.* 
	rm -f formatdb.log
