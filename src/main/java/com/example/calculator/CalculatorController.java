package com.example.calculator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/calculator")
public class CalculatorController {

    @Autowired
    private CalculatorService calculatorService;

    @GetMapping("/calculate")
    public double calculate(@RequestParam double num1, @RequestParam double num2, @RequestParam char op) {
        return calculatorService.calculate(num1, num2, op);
    }
}
