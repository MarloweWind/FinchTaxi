//
//  DateView.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 01.04.2022.
//

import UIKit

final class DateView: UIView {
    
    // MARK: - Locals
    
    private enum Locals {
        static let readyText = "Готово"
    }
    
    
    // MARK: - Properties
    
    private let calenderImageView = UIImageView()
    private let dateLabel = UILabel()
    private let detailDatetextField = UITextField()
    private let clockUiImageView = UIImageView()
    private let timeLabel = UILabel()
    private let detailTimeTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let dateFormat = DateFormatter()
    

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        let currentDate = Date()
        
        backgroundColor = .white
        
        let dateDoneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        dateDoneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dateDone: UIBarButtonItem = UIBarButtonItem(title: Locals.readyText,
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(self.dateDoneButtonAction))
        let dateItems = [flexSpace, dateDone]
        dateDoneToolbar.items = dateItems
        dateDoneToolbar.sizeToFit()
        detailDatetextField.inputAccessoryView = dateDoneToolbar
        detailTimeTextField.inputAccessoryView = dateDoneToolbar
        
        datePicker.date = Date()
        datePicker.locale = Locale(identifier: "ru_RU")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = currentDate
        dateFormat.locale = Locale(identifier: "ru_RU")
        
        calenderImageView.translatesAutoresizingMaskIntoConstraints = false
        calenderImageView.image = UIImage(named: "calender")
        
        setupLabel(dateLabel,
                   color: .finchLighGrey,
                   textSize: 14)
        
        setuptextField(detailDatetextField)
        
        clockUiImageView.translatesAutoresizingMaskIntoConstraints = false
        clockUiImageView.image = UIImage(named: "clock")
        
        setupLabel(timeLabel,
                   color: .finchGrey,
                   textSize: 14)
        
        setuptextField(detailTimeTextField)
        
        addSubview(calenderImageView)
        addSubview(dateLabel)
        addSubview(detailDatetextField)
        addSubview(clockUiImageView)
        addSubview(timeLabel)
        addSubview(detailTimeTextField)
        
        NSLayoutConstraint.activate([
            calenderImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            calenderImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            dateLabel.leftAnchor.constraint(equalTo: calenderImageView.leftAnchor, constant: 24),
            dateLabel.topAnchor.constraint(equalTo: calenderImageView.topAnchor),
            
            detailDatetextField.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 24),
            detailDatetextField.leftAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: 0),
            
            clockUiImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 200),
            clockUiImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            timeLabel.leftAnchor.constraint(equalTo: clockUiImageView.leftAnchor, constant: 24),
            timeLabel.topAnchor.constraint(equalTo: calenderImageView.topAnchor),
            
            detailTimeTextField.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 24),
            detailTimeTextField.leftAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: 0),
            detailTimeTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
            
            ])
    }
    

    // MARK: - Private methods
    
    private func setupLabel(_ label: UILabel, color: UIColor, textSize: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: .regular, size: textSize)
        label.textColor = color
    }
    
    private func setuptextField(_ textField: UITextField) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: .regular, size: 16)
        textField.textColor = .black
        textField.inputView = datePicker
        textField.delegate = self
    }
    
    
    // MARK: - Actions
    
    @objc func dateDoneButtonAction(){
        
        if detailDatetextField.isFirstResponder {
            dateFormat.dateFormat = "dd MMMM yyyy"
            detailDatetextField.resignFirstResponder()
            detailDatetextField.text = dateFormat.string(from: datePicker.date)
        }
        if detailTimeTextField.isFirstResponder {
            dateFormat.dateFormat = "HH:mm"
            detailTimeTextField.resignFirstResponder()
            detailTimeTextField.text = dateFormat.string(from: datePicker.date)
        }
    }

}


// MARK: - Configurable
extension DateView: Configurable {
    func configure(with model: Model) {
        dateLabel.text = model.dateLabelText
        detailDatetextField.attributedPlaceholder = NSAttributedString(
            string: model.dateDetailLabelText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
        timeLabel.text = model.timeLabelText
        detailTimeTextField.attributedPlaceholder = NSAttributedString(
            string: model.detailTimeLabelText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
    }
    
    struct Model {
        let dateLabelText: String
        let dateDetailLabelText: String
        let timeLabelText: String
        let detailTimeLabelText: String
    }
}


// MARK: - UITextFieldDelegate
extension DateView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == detailDatetextField {
            datePicker.datePickerMode = .date
        }
        if textField == detailTimeTextField {
            datePicker.datePickerMode = .time
        }
    }
}
