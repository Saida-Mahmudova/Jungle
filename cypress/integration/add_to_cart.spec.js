describe('Homepage testing', () => {
  beforeEach(() => {
    cy.visit('/')
  });

  it('Can click to add to cart button', () => {
    cy.get('.products button.btn').first().click({ force: true });
    cy.contains("My Cart").should('contain', '1');
  });
})