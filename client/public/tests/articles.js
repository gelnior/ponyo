
  describe('Article creation', function() {
    it('Given I browse a category', function() {
      runs(function() {
        $("#category-field").val("Category Jasmine");
        return $("#category-add-submit").click();
      });
      waits(300);
      runs(function() {
        return $("#category-jasmine").click();
      });
      return waits(300);
    });
    it('When I fill the new article title field', function() {
      return runs(function() {
        return $("#article-field").val("Article Jasmine");
      });
    });
    it('And I click on add button', function() {
      runs(function() {
        return $("#article-add-submit").click();
      });
      return waits(500);
    });
    return it('Then a new article with given title and actual date is displayed', function() {
      return runs(function() {
        var date;
        date = moment().format("YYYY-MM-DD-");
        return expect($("#" + date + "article-jasmine").length).not.toEqual(0);
      });
    });
  });

  describe('Article browsing', function() {
    it('When I click on an article', function() {
      runs(function() {
        var date;
        date = moment().format("YYYY-MM-DD-");
        return $("#" + date + "article-jasmine").click();
      });
      return waits(300);
    });
    return it('Then I display the article page', function() {
      return runs(function() {
        return expect($(".article-title").length).not.toEqual(0);
      });
    });
  });
