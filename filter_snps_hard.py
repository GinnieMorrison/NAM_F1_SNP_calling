##written for python 2.7.x b/c that's what's easy on farm right now (5/1/2015)
import string
import sys


def main():
    
    geno_file=sys.argv[1]
    filter_pass=sys.argv[2]
     
    with open(geno_file,'r') as geno_in, open(filter_pass,'w') as write_file:
        geno_lines=geno_in.read().splitlines()
        for pos in geno_lines:
            base_line=pos.split('\t')
            #print len(base_line) 81 long.
            ref=base_line[4]
            nams=[base_line[i] for i in range(6,57,2)]
            #print i, len(nams)
            f1s=[base_line[j] for j in range(58,80,2)]
            #print j, f1s[-1], len(f1s)
            
            if ref =='0' or ref == '-1':
                #print "ok"
                if all(x in ['0','2','-1'] for x in nams):
                    #print "ok2"
                    if all(y in ['0','1','-1'] for y in f1s):
                        #print "ok3"
                        pass_line="\t".join(base_line[0:-1])
                        write_file.write("%s\n"%pass_line)
                        
main()