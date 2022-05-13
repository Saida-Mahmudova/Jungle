describe('Product testing', () => {
  beforeEach(() => {
    cy.visit('/')
  });

  it("can click on a product", () => {
    cy.get(".products article").should("be.visible");
    cy.get(".products article").first().click();
    cy.url().should('include', '/products')
  });
})