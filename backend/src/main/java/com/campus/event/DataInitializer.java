package com.campus.event;

import com.campus.event.models.ERole;
import com.campus.event.models.Role;
import com.campus.event.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    RoleRepository roleRepository;

    @Override
    public void run(String... args) throws Exception {
        if (roleRepository.findByName(ERole.ROLE_STUDENT).isEmpty()) {
            Role roleStudent = new Role();
            roleStudent.setName(ERole.ROLE_STUDENT);
            roleRepository.save(roleStudent);
        }

        if (roleRepository.findByName(ERole.ROLE_ORGANIZER).isEmpty()) {
            Role roleOrganizer = new Role();
            roleOrganizer.setName(ERole.ROLE_ORGANIZER);
            roleRepository.save(roleOrganizer);
        }

        if (roleRepository.findByName(ERole.ROLE_ADMIN).isEmpty()) {
            Role roleAdmin = new Role();
            roleAdmin.setName(ERole.ROLE_ADMIN);
            roleRepository.save(roleAdmin);
        }
    }
}
