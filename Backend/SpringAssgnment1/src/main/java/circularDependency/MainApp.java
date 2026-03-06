package circularDependency;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class MainApp {

    public static void main(String[] args) {

        try {
            ConfigurableApplicationContext context =
                    new AnnotationConfigApplicationContext(AppConfig.class);

            context.getBean(A.class);

            context.close();

        } catch (Exception e) {
            System.out.println("Circular dependency detected between beans A and B.");
            System.out.println("Spring cannot resolve circular dependency with constructor injection.");
        }
    }
}

