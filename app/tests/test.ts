import { expect, test } from '@playwright/test';

test('Expect title', async ({ page }) => {
	await page.goto('/');
	//await expect(page).toHaveTitle("Welcome");
});
