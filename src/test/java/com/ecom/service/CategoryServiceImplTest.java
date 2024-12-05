package com.ecom.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.ecom.model.Category;
import com.ecom.repository.CategoryRepository;
import com.ecom.service.impl.CategoryServiceImpl;

public class CategoryServiceImplTest {

	@Mock
	private CategoryRepository categoryRepository;

	@InjectMocks
	private CategoryServiceImpl categoryService;

	@BeforeEach
	public void setup() {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	public void testSaveCategory_Success() {
		// Arrange
		Category category = new Category();
		when(categoryRepository.save(category)).thenReturn(category);

		// Act
		Category savedCategory = categoryService.saveCategory(category);

		// Assert
		assertNotNull(savedCategory);
		verify(categoryRepository, times(1)).save(category);
	}

	@Test
	public void testSaveCategory_Failure() {
		// Arrange
		Category category = new Category();
		when(categoryRepository.save(category)).thenThrow(new RuntimeException("Save failed"));

		// Act & Assert
		assertThrows(RuntimeException.class, () -> {
			categoryService.saveCategory(category);
		});
	}

	@Test
	public void testGetAllCategory_Success() {
		// Arrange
		List<Category> categories = new ArrayList<>();
		categories.add(new Category());
		when(categoryRepository.findAll()).thenReturn(categories);

		// Act
		List<Category> result = categoryService.getAllCategory();

		// Assert
		assertEquals(1, result.size());
		verify(categoryRepository, times(1)).findAll();
	}

	@Test
	public void testGetAllCategory_Failure() {
		// Arrange
		when(categoryRepository.findAll()).thenReturn(new ArrayList<>());

		// Act
		List<Category> result = categoryService.getAllCategory();

		// Assert
		assertTrue(result.isEmpty());
	}

	@Test
	public void testExistCategory_Success() {
		// Arrange
		when(categoryRepository.existsByName("Electronics")).thenReturn(true);

		// Act
		Boolean exists = categoryService.existCategory("Electronics");

		// Assert
		assertTrue(exists);
		verify(categoryRepository, times(1)).existsByName("Electronics");
	}

	@Test
	public void testExistCategory_Failure() {
		// Arrange
		when(categoryRepository.existsByName("NonExistentCategory")).thenReturn(false);

		// Act
		Boolean exists = categoryService.existCategory("NonExistentCategory");

		// Assert
		assertFalse(exists);
	}

	@Test
	public void testDeleteCategory_Success() {
		// Arrange
		Category category = new Category();
		when(categoryRepository.findById(1)).thenReturn(Optional.of(category));

		// Act
		Boolean result = categoryService.deleteCategory(1);

		// Assert
		assertTrue(result);
		verify(categoryRepository, times(1)).delete(category);
	}

	@Test
	public void testDeleteCategory_Failure() {
		// Arrange
		when(categoryRepository.findById(1)).thenReturn(Optional.empty());

		// Act
		Boolean result = categoryService.deleteCategory(1);

		// Assert
		assertFalse(result);
		verify(categoryRepository, never()).delete(any(Category.class));
	}

	@Test
	public void testGetCategoryById_Success() {
		// Arrange
		Category category = new Category();
		when(categoryRepository.findById(1)).thenReturn(Optional.of(category));

		// Act
		Category result = categoryService.getCategoryById(1);

		// Assert
		assertNotNull(result);
		verify(categoryRepository, times(1)).findById(1);
	}

	@Test
	public void testGetCategoryById_Failure() {
		// Arrange
		when(categoryRepository.findById(1)).thenReturn(Optional.empty());

		// Act
		Category result = categoryService.getCategoryById(1);

		// Assert
		assertNull(result);
	}

	@Test
	public void testGetAllActiveCategory_Success() {
		// Arrange
		List<Category> categories = new ArrayList<>();
		categories.add(new Category());
		when(categoryRepository.findByIsActiveTrue()).thenReturn(categories);

		// Act
		List<Category> result = categoryService.getAllActiveCategory();

		// Assert
		assertEquals(1, result.size());
		verify(categoryRepository, times(1)).findByIsActiveTrue();
	}

	@Test
	public void testGetAllActiveCategory_Failure() {
		// Arrange
		when(categoryRepository.findByIsActiveTrue()).thenReturn(new ArrayList<>());

		// Act
		List<Category> result = categoryService.getAllActiveCategory();

		// Assert
		assertTrue(result.isEmpty());
	}

	@Test
	public void testGetAllCategorPagination_Success() {
		// Arrange
		Pageable pageable = PageRequest.of(0, 10);
		List<Category> categories = new ArrayList<>();
		categories.add(new Category());
		Page<Category> categoryPage = new PageImpl<>(categories);
		when(categoryRepository.findAll(pageable)).thenReturn(categoryPage);

		// Act
		Page<Category> result = categoryService.getAllCategorPagination(0, 10);

		// Assert
		assertEquals(1, result.getContent().size());
		verify(categoryRepository, times(1)).findAll(pageable);
	}

	@Test
	public void testGetAllCategorPagination_Failure() {
		// Arrange
		Pageable pageable = PageRequest.of(0, 10);
		when(categoryRepository.findAll(pageable)).thenReturn(Page.empty());

		// Act
		Page<Category> result = categoryService.getAllCategorPagination(0, 10);

		// Assert
		assertTrue(result.isEmpty());
	}

}
