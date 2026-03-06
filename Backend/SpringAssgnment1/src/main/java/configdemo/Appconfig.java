package configdemo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Appconfig {

    @Bean
    public UserRepo userRepository() {
        return new UserRepo();
    }

    @Bean
    public UserService userService() {
        return new UserService(userRepository());
    }
}

