# usage: bash amr2dot.sh path/to/amr/file path/to/output/file i
# i is optional, the index of the graph to convert.
# if i is not given, we do them all.
# turns AMRs into graphviz graphs all in one file, say out.dot, then turns them all into pdfs called out.dot.n.pdf

if [ -z "$3" ]
  then python main.py  --read amr --write dot $1 $2
else
    python main.py --i $3 --read amr --write dot $1 $2
fi

# flip -of edges
sed -i.bak -r 's/([0-9]+) -> ([0-9]+)( .*)\((\w+)\)(-of)/\2 -> \1\3\4/g' $2

# remove (domain) from 'mod (domain)' edges
sed -i.bak -r 's/ \(domain\)//g' $2

dot -Tpdf -O $2
