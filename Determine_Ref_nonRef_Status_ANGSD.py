##written for python 2.7.x b/c that's what's easy on farm right now (5/1/2015)
import string
import sys

def change_call(call):
     if call=='0':
          return '2'
     elif call=='2':
          return '0'
     else:
          return call

def alt_alleles(alt_c):
     if alt_c =='0':
          return '3'
     elif alt_c == '1':
          return '4'
     elif alt_c=='2':
          return '5'
     else:
          return alt_c

def main():
     fasta_file=sys.argv[1]
     fixed_file=sys.argv[2]
     
     with open(fasta_file,'r') as fasta_in, open(fixed_file,'w') as write_file:
          fasta_read=fasta_in.read()
          fasta_lines=fasta_read.splitlines()
          for position in fasta_lines:
               ref, chrm, pos, maj, minor, nTIL, chrTIL, nF2, chrF2,blank=position.split('\t')
               #print ref, maj, minor, nTIL, nF2
               
               if ref == minor:
                    nTIL=change_call(nTIL)
                    #print nTIL
                    nF2=change_call(nF2)
                    #print nF2
                    fixed_line="\t".join([ref, chrm, pos, maj, minor, nTIL, chrTIL, nF2, chrF2])

               if ref !=minor and ref !=maj:
                    nTIL=alt_alleles(nTIL)
                    nF2=alt_alleles(nTIL)
                    #print nTIL, nF2
                    fixed_line="\t".join([ref, chrm, pos, maj, minor, nTIL, chrTIL, nF2, chrF2])
               else:
                    fixed_line="\t".join([ref, chrm, pos, maj, minor, nTIL, chrTIL, nF2, chrF2])
               #print fixed_line
               write_file.write("%s\n"%fixed_line)

main()
