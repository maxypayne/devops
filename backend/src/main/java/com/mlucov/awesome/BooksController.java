package com.mlucov.awesome;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/books")
public class BooksController {

  @GetMapping
  public String getData() {
    return "Hello World  changed";
  }
}