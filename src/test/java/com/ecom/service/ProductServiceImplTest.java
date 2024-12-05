package com.ecom.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.model.Product;
import com.ecom.repository.ProductRepository;
import com.ecom.service.impl.ProductServiceImpl;


public class ProductServiceImplTest {

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private ProductServiceImpl productService;

    @Mock
    private MultipartFile multipartFile;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }
    
        @Test
    public void testSaveProductSuccess() {
        Product product = new Product();
        product.setId(1);
        product.setTitle("Test Product");

        when(productRepository.save(product)).thenReturn(product);

        Product savedProduct = productService.saveProduct(product);
        assertNotNull(savedProduct);
        assertEquals(1, savedProduct.getId());
    }

    @Test
    public void testSaveProductFailure() {
        Product product = new Product();

        when(productRepository.save(product)).thenThrow(new RuntimeException("Failed to save product"));

        assertThrows(RuntimeException.class, () -> productService.saveProduct(product));
    }

    @Test
    public void testGetAllProductsSuccess() {
        List<Product> products = List.of(new Product(), new Product());

        when(productRepository.findAll()).thenReturn(products);

        List<Product> result = productService.getAllProducts();
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    public void testGetAllProductsFailure() {
        when(productRepository.findAll()).thenReturn(null);

        List<Product> result = productService.getAllProducts();
        assertNull(result);
    }

    @Test
    public void testGetAllProductsPaginationSuccess() {
        Page<Product> productPage = mock(Page.class);
        Pageable pageable = PageRequest.of(0, 5);

        when(productRepository.findAll(pageable)).thenReturn(productPage);

        Page<Product> result = productService.getAllProductsPagination(0, 5);
        assertNotNull(result);
    }

    @Test
    public void testGetAllProductsPaginationFailure() {
        Pageable pageable = PageRequest.of(0, 5);

        when(productRepository.findAll(pageable)).thenReturn(Page.empty());

        Page<Product> result = productService.getAllProductsPagination(0, 5);
        assertTrue(result.isEmpty());
    }

    @Test
    public void testDeleteProductSuccess() {
        Product product = new Product();
        product.setId(1);

        when(productRepository.findById(1)).thenReturn(Optional.of(product));
        Boolean isDeleted = productService.deleteProduct(1);

        assertTrue(isDeleted);
        verify(productRepository, times(1)).delete(product);
    }

    @Test
    public void testDeleteProductFailure() {
        when(productRepository.findById(1)).thenReturn(Optional.empty());

        Boolean isDeleted = productService.deleteProduct(1);
        assertFalse(isDeleted);
    }

    @Test
    public void testGetProductByIdSuccess() {
        Product product = new Product();
        product.setId(1);

        when(productRepository.findById(1)).thenReturn(Optional.of(product));

        Product foundProduct = productService.getProductById(1);
        assertNotNull(foundProduct);
    }

    @Test
    public void testGetProductByIdFailure() {
        when(productRepository.findById(1)).thenReturn(Optional.empty());

        Product product = productService.getProductById(1);
        assertNull(product);
    }

    @Test
    public void testGetAllActiveProductsSuccess() {
        List<Product> products = List.of(new Product(), new Product());

        when(productRepository.findByIsActiveTrue()).thenReturn(products);

        List<Product> result = productService.getAllActiveProducts(null);
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    public void testGetAllActiveProductsFailure() {
        when(productRepository.findByIsActiveTrue()).thenReturn(null);

        List<Product> result = productService.getAllActiveProducts(null);
        assertNull(result);
    }

    @Test
    public void testSearchProductSuccess() {
        List<Product> products = List.of(new Product(), new Product());

        when(productRepository.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("test", "test"))
            .thenReturn(products);

        List<Product> result = productService.searchProduct("test");
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    public void testSearchProductFailure() {
        when(productRepository.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("test", "test"))
            .thenReturn(null);

        List<Product> result = productService.searchProduct("test");
        assertNull(result);
    }

    @Test
    public void testGetAllActiveProductPaginationSuccess() {
        Page<Product> productPage = mock(Page.class);
        Pageable pageable = PageRequest.of(0, 5);

        when(productRepository.findByIsActiveTrue(pageable)).thenReturn(productPage);

        Page<Product> result = productService.getAllActiveProductPagination(0, 5, null);
        assertNotNull(result);
    }

    @Test
    public void testGetAllActiveProductPaginationFailure() {
        Pageable pageable = PageRequest.of(0, 5);

        when(productRepository.findByIsActiveTrue(pageable)).thenReturn(Page.empty());

        Page<Product> result = productService.getAllActiveProductPagination(0, 5, null);
        assertTrue(result.isEmpty());
    }

    @Test
    public void testSearchActiveProductPaginationSuccess() {
        Page<Product> productPage = mock(Page.class);
        Pageable pageable = PageRequest.of(0, 5);

        when(productRepository.findByisActiveTrueAndTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("test", "test", pageable))
            .thenReturn(productPage);

        Page<Product> result = productService.searchActiveProductPagination(0, 5, null, "test");
        assertNotNull(result);
    }

    @Test
    public void testSearchActiveProductPaginationFailure() {
        Pageable pageable = PageRequest.of(0, 5);

        when(productRepository.findByisActiveTrueAndTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("test", "test", pageable))
            .thenReturn(Page.empty());

        Page<Product> result = productService.searchActiveProductPagination(0, 5, null, "test");
        assertTrue(result.isEmpty());
    }


}