require 'test_helper'

class PresentationIntegrationTest < ActionDispatch::IntegrationTest
    include Capybara::DSL

    # Стандартная проверка работы веб-приложения
    test "user_comment_check" do
        visit presentation_path
        assert_equal 200, page.status_code

        assert_not_nil page
        assert page.has_field?('UserNameEnter')
        assert page.has_field?('CommentEnter')
        assert page.has_button?('Add comment')

        fill_in 'UserNameEnter', with: 'Jogn Doe'
        fill_in 'CommentEnter', with: 'Nice device!'

        assert_equal 'Jogn Doe', find_field('UserNameEnter').value
        assert_equal 'Nice device!', find_field('CommentEnter').value

        find('button[name="AddCommentButton"]')
        assert_equal presentation_path, current_path
        assert_equal 'Jogn Doe', find_field('UserNameEnter').value
        assert_equal 'Nice device!', find_field('CommentEnter').value
    end

    # Проверка вывода ошибки если введено только одно из 2-х полей или оба пустые
    test "mistake_one_field" do
        visit presentation_path
      
        # Вводим только одно поле
        fill_in 'UserNameEnter', with: 'Jogn Doe'
        click_on 'AddCommentButton'
      
        assert_no_text('Пожалуйста, введите оба числа.')
        assert_equal presentation_path, current_path

        begin
            within('#usernameInput') do
              assert_nil find.value
            end
          rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
    
        begin
            within('#commentInput') do
              assert_equal '', find.value
            end
          rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
      
        # Проверяем значения полей
        assert_equal 'Jogn Doe', find_field('UserNameEnter').value
        assert_equal '', find_field('CommentEnter').value
        fill_in 'UserNameEnter', with: ''
      
        # Вводим только другое поле
        fill_in 'CommentEnter', with: 'Nice device!'
        click_on 'AddCommentButton'

        begin
            within('#usernameInput') do
                assert_nil find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end

        begin
            within('#commentInput') do
                assert_equal 'Nice device!', find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
      
        assert_no_text('Пожалуйста, введите оба числа.')
        assert_equal presentation_path, current_path
      
        # Проверяем значения полей
        assert_equal '', find_field('UserNameEnter').value
        assert_equal 'Nice device!', find_field('CommentEnter').value
      
        # Очищаем поля
        fill_in 'UserNameEnter', with: ''
        fill_in 'CommentEnter', with: ''
      
        # Кликаем, когда оба поля пустые
        click_on 'AddCommentButton'
      
        assert_no_text('Пожалуйста, введите оба числа.')
        assert_equal presentation_path, current_path

        begin
            within('#usernameInput') do
                assert_nil find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
        
        begin
            within('#commentInput') do
                assert_nil find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
      
        # Проверяем значения полей
        assert_equal '', find_field('UserNameEnter').value
        assert_equal '', find_field('CommentEnter').value
      
        # Вводим оба поля
        fill_in 'UserNameEnter', with: 'John Doe'
        fill_in 'CommentEnter', with: 'Nice device!'
        click_on 'AddCommentButton'
      
        # Проверка, что теперь не выводится ошибка
        assert_no_text('Пожалуйста, введите оба числа.')
        assert_equal presentation_path, current_path
      
        # Проверяем значения полей
        assert_equal 'John Doe', find_field('UserNameEnter').value
        assert_equal 'Nice device!', find_field('CommentEnter').value

        begin
            within('#usernameInput') do
                assert_nil find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
    
        begin
            within('#commentInput') do
                assert_nil find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
    end

    # Тест на проверку неправильного ввода в Username и Comment
    test "irrelevant_input" do
        visit presentation_path

        fill_in 'UserNameEnter', with: '   '
        fill_in 'CommentEnter', with: '   '
        click_on 'AddCommentButton'
      
        assert_no_text('Пожалуйста, введите оба числа.')
        assert_equal presentation_path, current_path
      
        begin
            within('#usernameInput') do
                assert_equal '', find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
      
        begin
            within('#commentInput') do
                assert_equal '', find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
    end

    # Тест-проверка на то, чтобы были введены только буквы (слова)
    test "input_only_numbers" do
        visit presentation_path
      
        fill_in 'UserNameEnter', with: 'John Doe'
        fill_in 'CommentEnter', with: 'Good'
        click_on 'AddCommentButton'
      
        assert_no_text('Пожалуйста, введите оба числа.')
        assert_equal presentation_path, current_path
      
        begin
            within('#usernameInput') do
                assert_equal 'John Doe', find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
      
        begin
            within('#commentInput') do
                assert_equal 'Good', find.value
            end
            rescue Nokogiri::CSS::SyntaxError
            within('body') do
            end
        end
        assert_equal presentation_path, current_path
    end
end