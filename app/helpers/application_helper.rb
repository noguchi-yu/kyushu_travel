module ApplicationHelper
  # デバイスのエラーメッセージ出力メソッド
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    # エラーメッセージ用のHTMLを生成
    messages = resource.errors.full_messages.each do |msg|
      html += <<-EOF
        <div role="alert" class="bg-base-200 text-red-500 flex flex-col items-start">
          <span>#{msg}</span>
        </div>
      EOF
    end
    html.html_safe
  end
end
