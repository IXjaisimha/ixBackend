package com.example.SpringAssignment3;


import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class AppRunner {
    @Value("${app.name}")
    private String appName;

    @Value("${app.description}")
    private String welcomeMessage;

    @PostConstruct
    public void run() {
        System.out.println("Running AppName : " + appName);
        System.out.println("Description Of App : "+welcomeMessage);
    }


}
