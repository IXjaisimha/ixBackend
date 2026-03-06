package lifecycle;

import beans.HelloWorld;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Client {
    public static void main(String[] args) {

        ConfigurableApplicationContext context =
                new ClassPathXmlApplicationContext("spring.xml");

        HelloWorld obj = context.getBean("hw", HelloWorld.class);

        context.close();
    }
}

