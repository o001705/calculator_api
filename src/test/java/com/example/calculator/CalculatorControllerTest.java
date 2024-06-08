package com.example.calculator;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.lang.reflect.Field;

public class CalculatorControllerTest {

    private MockMvc mockMvc;

    @BeforeEach
    public void setUp() throws NoSuchFieldException, IllegalAccessException {
        CalculatorController calculatorController = new CalculatorController();
        CalculatorService calculatorService = new CalculatorService();
        Field field = CalculatorController.class.getDeclaredField("calculatorService");
        field.setAccessible(true);
        field.set(calculatorController, calculatorService);
        mockMvc = MockMvcBuilders.standaloneSetup(calculatorController).build();
    }

    @Test
    public void testAddition() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/api/calculator/calculate")
                        .param("num1", "10")
                        .param("num2", "5")
                        .param("op", "+"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(content().string("15.0"));
    }

    @Test
    public void testSubtraction() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/api/calculator/calculate")
                        .param("num1", "10")
                        .param("num2", "5")
                        .param("op", "-"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(content().string("5.0"));
    }

    @Test
    public void testMultiplication() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/api/calculator/calculate")
                        .param("num1", "10")
                        .param("num2", "5")
                        .param("op", "*"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(content().string("50.0"));
    }

    @Test
    public void testDivision() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/api/calculator/calculate")
                        .param("num1", "10")
                        .param("num2", "5")
                        .param("op", "/"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(content().string("2.0"));
    }

}
