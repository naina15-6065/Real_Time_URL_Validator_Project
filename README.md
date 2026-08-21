# Real Time URL Validator

**A real-time URL validation and parsing system built using Lex and Yacc/Bison that analyzes URL structure, validates syntax, and extracts key components such as protocol, domain, port, path, query, and fragment.** 

---

##  About

**Real-Time URL Validator Compiler** is a compiler-based URL validation system designed to validate and analyze web addresses in real time. The system uses **Lex for lexical analysis** and **Yacc/Bison for syntax analysis** to tokenize URL components and verify them against predefined grammar rules. 

### Key Highlights

* **Lexical Analysis** – Tokenizes protocols, domains, ports, paths, queries, and fragments.
* **Syntax Analysis** – Uses Yacc/Bison grammar rules to verify the structural validity of URLs.
* **URL Component Extraction** – Breaks valid URLs into protocol, domain, port, path, query, and fragment.
* **Real-Time Validation** – Provides immediate feedback for valid and malformed URLs.
* **Error Detection** – Identifies syntax errors and rejects invalid URL structures.
* **Efficient Processing** – Works in linear time relative to the input length with minimal memory usage.  

---

##  Features

###  Lexical Analysis

The Lex analyzer identifies different URL components, including:

* HTTP, HTTPS, and FTP protocols
* Domain names
* Port numbers
* Paths
* Query parameters
* Fragments
* URL separators and identifiers 

###  Syntax Analysis

Yacc/Bison validates the URL according to the defined grammar:

**Protocol → Domain → [Port] → [Path] → [Query] → [Fragment]**

Optional components such as query strings and fragments are supported. Invalid structures generate syntax error messages. 

###  URL Parsing

For a valid URL, the system extracts:

* **Protocol**
* **Domain**
* **Port**
* **Path**
* **Query**
* **Fragment**

This provides a clear structural breakdown of the entered web address. 

###  Real-Time Validation

The compiler provides near-instant validation and handles both valid and invalid URL patterns efficiently. It was tested with simple domains, subdomains, ports, paths, queries, and fragments. 

###  Error Handling

Malformed URLs are rejected with appropriate syntax error messages. For example, the system detects incorrect URL structures and prompts the user to enter another URL. 

---

##  Tech Stack

* **C**
* **Lex / Flex** – Lexical Analysis
* **Yacc / Bison** – Syntax Analysis
* **Regular Expressions**
* **Context-Free Grammar**
* **Compiler Design Concepts**

---

##  System Workflow

**URL Input → Lexical Analysis → Tokenization → Yacc/Bison Parsing → Grammar Validation → URL Component Extraction → Result/Error**

The project integrates Lex and Yacc/Bison with a C driver program to create the complete URL validation compiler. 

