package beans.Config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Bean;

@Configuration
@ComponentScan("beans")
public class AppConfig {

    @Bean
    public String appName(){
        return "Working Spring Application Core";
    }

}

