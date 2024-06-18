package com.nikita.shop.repositories;

import com.nikita.shop.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByTitle(String title);
    List<Product> findByCity(String city);
    List<Product> findByCityAndTitle(String city, String title); // Для поиска по городу и ключевому слову
    List<Product> findByCityContaining(String city);

}
