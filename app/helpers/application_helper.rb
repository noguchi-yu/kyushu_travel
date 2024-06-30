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

  def extract_address(address)
    # 正規表現を使用して、郵便番号と都道府県以降の住所を抽出
    match_data = address.match(/〒\d{3}-\d{4}\s(.+)/)
    if match_data
      return match_data[1]  # 郵便番号以降の住所を返す
    else
      return address  # マッチしない場合はnilを返す
    end
  end
end
