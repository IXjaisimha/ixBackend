package com.example.SpringAssignment3;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {
    @RequestMapping("/")
    @ResponseBody
        public String home() {
            return "Welcome to Home Page!";
        }


    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    @ResponseBody
    public String sayHello() {
        return "Hello, World!";
    }
}
