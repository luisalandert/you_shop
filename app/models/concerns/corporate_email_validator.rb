class CorporateEmailValidator < ActiveModel::Validator
  def validate(record)
    corporate_emails = []
    Company.all.each do |corporate_email|
      corporate_emails << corporate_email.email_domain
    end
    if !corporate_emails.include? record.email[/\@(.*)/]
      record.errors.add(:email, 'corporativo não encontrado, empresa deve estar cadastrada para completar seu registro!')
    end
  end
end