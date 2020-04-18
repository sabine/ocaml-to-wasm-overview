files = a01_closures a02_match a03_fibonacci a04_factorial c01_while

all: $(files:=.cmm) $(files:=.s) $(files:=.clambda)
	rm -rf *.cmx *.cmi *.o a.out

%.cmm: %.ml
	ocamlopt $< -dcmm 2> $@

%.s: %.ml
	ocamlopt $< -S -inline 0 -nodynlink

%.clambda: %.ml
	ocamlopt $< -dclambda 2> $@

clean:
	rm -rf *.cmx *.cmi *.o a.out *.cmm *.s *.clambda

