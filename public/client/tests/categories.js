
  describe('Category browsing', function() {
    it('Add Category jasmine', function() {
      waitsFor(function() {
        return $("#category-field").length > 0;
      }, "Page did not get loaded", 2000);
      runs(function() {
        $("#category-field").val("Category Jasmine");
        return $("#category-add-submit").click();
      });
      waits(500);
      return runs(function() {
        return expect($("#category-jasmine").length).not.toEqual(0);
      });
    });
    it('Displays Category jasmine', function() {
      runs(function() {
        return $("#category-jasmine").click();
      });
      waits(500);
      return runs(function() {
        return expect($("#back-categories").length).not.toEqual(0);
      });
    });
    return it('Goes back to category list', function() {
      runs(function() {
        $("#back-categories").click();
        return window.location.href = $("#back-categories").attr("href");
      });
      waits(500);
      return runs(function() {
        return expect($("#category-list").length).not.toEqual(0);
      });
    });
  });

  describe('Category deletion', function() {
    it('When I display newly created category', function() {
      runs(function() {
        return $("#category-jasmine").click();
      });
      return waits(500);
    });
    it('And I click on delete category button from a category page', function() {
      runs(function() {
        return $("#delete-category-button").click();
      });
      return waits(500);
    });
    it('Then it brings me back to category list', function() {
      return runs(function() {
        return expect($("#category-list").length).not.toEqual(0);
      });
    });
    return it('And deleted activity is no more in the list', function() {
      return runs(function() {
        return expect($("#category-jamsine").length).toEqual(0);
      });
    });
  });
