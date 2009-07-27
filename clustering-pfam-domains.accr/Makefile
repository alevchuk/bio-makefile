SPLIT_NUM=100
SEQSPLIT=/usr/local/bin/seqsplit-fasta
DIR = $(shell pwd)

main:
	$(SEQSPLIT) -i \
	$(DIR)/UPDATED.fasta \
	-L $(SPLIT_NUM) -p 'searchspace-' -s 3
	
	$(DIR)/scripts/rename-searchspace-files
	
	$(DIR)/scripts/hmmpfam-E-4

clean:
	rm -rf *-searchspace
	rm -rf *-domains
	rm -rf STDIN.e*
	rm -rf STDIN.o*
