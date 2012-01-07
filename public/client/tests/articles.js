
  describe('Article creation', function() {
    it('Given I browse a category', function() {
      return runs(function() {
        if ($("#category-jasmine").length === 0) {
          $("#category-field").val("Category Jasmine");
          $("#category-add-submit").click();
          waits(300);
        }
        return $("#category-jasmine").click();
      });
    });
    it('When I fill the new article title field', function() {
      return runs(function() {
        return $("#article-field").val("Article Jasmine");
      });
    });
    it('And I click on add button', function() {
      runs(function() {
        $("#article-add-submit").click();
        return expect(false).toBeTruthy();
      });
      return waits(500);
    });
    return it('Then a new article with given title is displayed', function() {
      return runs(function() {
        return expect($("#article-jasmine").length).not.toEqual(0);
      });
    });
  });

  describe('Article browsing', function() {
    it('When I click on an article', function() {
      return $("#article-jasmine").click();
    });
    return it('Then I display the article page', function() {
      return runs(function() {
        return expect($("#article-jasmine-title").length).not.toEqual(0);
      });
    });
  });
