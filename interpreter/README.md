# interpreter

## language

``` text
code_name=cynix
file_extension=.cyn
```

## pipeline

``` text
[source code]
    -> tokenizer -> [tokens]
    -> parser -> [AST]                  # syntactic analysis
    -> bytecode emitter -> [byte code]  # optimization step
    -> interpreter -> [result]          # runtime
```

## AST

Expression:

``` text
total = current + 42;
```

Verbose:
``` javascript
{
    type: "Assignment",
    left: {
        type: "Identifier",
        value: "total"
    },
    right: {
        type: "Assignment",
        left: {
            type: "Identifier",
            value: "current"
        },
        right: {
            type: "Literal",
            value: 42
        }
    }
}
```


Simplified:
``` javascript
[
    "let",
    "total",
    [
        "+",
        "current",
        [
           42
        ]
    ]
]
```

Syntax:
``` text
(+ 2 40)

(let x 42)

(if (> x 10)
    (print "OK")
    (print "Error"))

(defun foo (bar)
    (+ bar 10))

(lambda (x) (* x x) 10)

(while (< i 10)
    (++ i))

(defun create_counter ()
    (begin
    (var i 0)
    (lambda () (++ i))))

(var count (create_counter))
(count) // 1
(count) // 2

```
