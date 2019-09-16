let add_dummy_loc (x : 'a) : 'a Wasm.Source.phrase = Wasm.Source.(x @@ no_region)

let fs = [
        add_dummy_loc {
                Wasm.Ast.ftype = add_dummy_loc 0l;
                Wasm.Ast.locals = [];
                Wasm.Ast.body = [add_dummy_loc (Wasm.Ast.Const (add_dummy_loc (Wasm.Values.I32 42l)))];
        }
        ]

let f_type = Wasm.Types.FuncType ([], [Wasm.Types.I32Type])

let f_export = {Wasm.Ast.name = Wasm.Utf8.decode "helloWorld";
                Wasm.Ast.edesc = add_dummy_loc (Wasm.Ast.FuncExport (add_dummy_loc 0l))}

let x = add_dummy_loc {Wasm.Ast.empty_module with 
        funcs = fs;
        types = [ add_dummy_loc f_type];
        exports = [ add_dummy_loc f_export ];
        }

let () =
        let encoded = Wasm.Encode.encode x in
        let oc = open_out "out.wasm" in
        Printf.fprintf oc "%s" encoded;
        close_out oc;
        print_endline encoded
