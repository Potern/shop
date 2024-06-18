package com.nikita.shop.services;

import com.nikita.shop.models.Image;
import com.nikita.shop.models.Product;
import com.nikita.shop.models.User;
import com.nikita.shop.repositories.ProductRepository;
import com.nikita.shop.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Product> productList(String title, String city) {
        if (city != null) {
            // If only city is provided, use findByTitle with an empty string (%) for title
            // This will match any title containing the specified city
            if (title == null || title.isEmpty()) {
                return productRepository.findByCityContaining(city);
            } else {
                return productRepository.findByCityAndTitle(city, title);
            }
        } else if (title != null) {
            return productRepository.findByTitle(title);
        } else {
            return productRepository.findAll();
        }
    }
    public List<Product> findAllByCity(String city) {
        List<Product> allProducts = productRepository.findAll();
        List<Product> allProductsByCity = new ArrayList<>();
        if (city == null) {
            return allProducts;
        }
        for (Product product : allProducts) {
            if (product.getCity().toLowerCase().startsWith(city.toLowerCase())) {
                allProductsByCity.add(product);
            }
        }
        return allProductsByCity;
    }

    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }
        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        productRepository.save(product);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteProduct(Long id) {
        Product product = productRepository.findById(id)
                .orElse(null);
        if (product != null) {
            productRepository.delete(product);
        }
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }


}
