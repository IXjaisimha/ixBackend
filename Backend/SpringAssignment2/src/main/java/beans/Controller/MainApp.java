package beans.Controller;

import beans.Service.GreetingService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import beans.Config.AppConfig;

public class MainApp {

    public static void main(String[] args) {

//        GreetingService service = new GreetingService();
//
//        System.out.println(service.greet("Jaisimha"));
        ApplicationContext context =
                new AnnotationConfigApplicationContext(AppConfig.class);

        GreetingService service =
                context.getBean(GreetingService.class);

        String message = service.greet("Jaisimha Kothari");

        System.out.println(message);

        String appName = context.getBean("appName", String.class);
        System.out.println(appName);
    }
}